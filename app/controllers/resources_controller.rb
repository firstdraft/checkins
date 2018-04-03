class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :authorize_lti_user
  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.all
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    @check_in = CheckIn.new(resource_id: @resource.id)
    # @check_ins = current_enrollment.check_ins.where(resource_id: params[:id])
    @check_ins = current_enrollment.check_ins.where(resource: @resource)
  end

  # GET /resources/new
  def new
    @resource = Resource.new
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, notice: 'Resource was successfully created.' }
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resources/1
  # PATCH/PUT /resources/1.json
  def update
    @resource.assign_attributes(resource_params)
    if @resource.inspect != Resource.find(@resource.id).inspect
      if @resource.save
        @resource.create_meetings(params["start_times"], params["end_times"])
        redirect_to @resource,
        notice: "Resource was successfully updated."
      else
        render :edit
      end
    else
      redirect_to @resource, notice: "Resource was unchanged"
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url, notice: 'Resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Resource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(
        :context_id,
        :meeting_schedule_hash,
        :starts_on,
        :ends_on,
        :sunday,
        :monday,
        :tuesday,
        :wednesday,
        :thursday,
        :friday,
        :saturday
      )
    end

    # def create_meetings(start_times_from_params, end_times_from_params)
    #   unless @resource.meetings.any?
    #     @resource.all_occurrences.each do |date|
    #       m = @resource.meetings.new(
    #         start_time: Chronic.parse(date.to_s + " " + start_times_from_params[date.wday.to_s]),
    #         end_time: Chronic.parse(date.to_s + " " + end_times_from_params[date.wday.to_s])
    #       )
    #       m.save
    #     end
    #   end
    # end

end
