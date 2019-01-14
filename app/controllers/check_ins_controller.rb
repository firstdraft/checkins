class CheckInsController < ApplicationController
  before_action :set_check_in, only: [:show, :edit, :update, :destroy]

  # GET /check_ins
  # GET /check_ins.json
  def index
    @check_ins = CheckIn.where(enrollment: current_enrollment)
  end

  # GET /check_ins/1
  # GET /check_ins/1.json
  def show
  end

  # GET /check_ins/new
  def new
    @check_in = CheckIn.new
  end

  # GET /check_ins/1/edit
  def edit
  end

  # POST /check_ins
  # POST /check_ins.json
  def create
    @check_in = CheckIn.new(check_in_params)
    respond_to do |format|
      if @check_in.save

        provider = IMS::LTI::ToolProvider.new(
          current_credential.consumer_key,
          current_credential.consumer_secret,
          current_launch.payload
        )
        p "==================================================================="
        p "provider.inspect:"
        p provider.inspect
        p "==================================================================="
        p "current_launch.payload:"
        p current_launch.payload
        p "==================================================================="
        p "outcome_service: #{provider.outcome_service?}"

        p response = provider.post_replace_result!(current_enrollment.grade_attendance)
        p result = response.description

        format.html { redirect_to resource_url(@check_in.resource), notice: result }
        format.json { render :show, status: :created, location: @check_in }
      else
        format.html { render :new }
        format.json { render json: @check_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /check_ins/1
  # PATCH/PUT /check_ins/1.json
  def update
    respond_to do |format|
      if @check_in.update(check_in_params)
        format.html { redirect_to @check_in, notice: 'Check in was successfully updated.' }
        format.json { render :show, status: :ok, location: @check_in }
      else
        format.html { render :edit }
        format.json { render json: @check_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /check_ins/1
  # DELETE /check_ins/1.json
  def destroy
    @check_in.destroy
    respond_to do |format|
      format.html { redirect_to resource_url(@check_in.resource), notice: 'Check in was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_check_in
      @check_in = CheckIn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def check_in_params
      params.require(:check_in).permit(:enrollment_id, :meeting_id, :latitude, :longitude)
    end
end
