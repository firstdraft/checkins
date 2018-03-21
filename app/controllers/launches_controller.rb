class LaunchesController < ApplicationController
  before_action :set_launch, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @launches = Launch.all
  end

  def show
  end

  def new
    @launch = Launch.new
  end

  def edit
  end

  def create
    find_credential
    find_resource_and_context
    if @resource && @context
      find_or_create_user
      find_or_create_enrollment
      set_current_enrollment
      @launch = Launch.new(payload:params, credential:@credential, enrollment:@enrollment)
      if @launch.save
        if learner?
          redirect_to resource_url(@resource)
        elsif teacher?
          redirect_to credentials_url
        else
          redirect_to root_url,
          notice: "You are neither a student nor a teacher for this assignment"
        end
      else
        redirect_to root_url,
        notice: @launch.errors.full_messages.join(" & ")
      end
    elsif teacher?
      @context ||= Context.create(lti_context_id: params["context_id"], credential: @credential, title: params["context_title"])
      @resource = @context.resources.create(lti_resource_link_id: params["resource_link_id"], lis_outcome_service_url: params["lis_outcome_service_url"])
      find_or_create_user
      find_or_create_enrollment
      set_current_enrollment
      @launch = Launch.new(payload:params, credential:@credential, enrollment:@enrollment)
      if @launch.save
        redirect_to edit_resource_url(@resource)
      else
        redirect_to root_url,
        notice: @launch.errors.full_messages.join(" & ")
      end
    else
      redirect_to root_url,
      notice: "Attendance assignment has not been setup yet"
    end
  end

  def update
    respond_to do |format|
      if @launch.update(launch_params)
        format.html { redirect_to @launch, notice: 'Launch was successfully updated.' }
        format.json { render :show, status: :ok, location: @launch }
      else
        format.html { render :edit }
        format.json { render json: @launch.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @launch.destroy
    respond_to do |format|
      format.html { redirect_to launches_url, notice: 'Launch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

    def set_launch
      @launch = Launch.find(params[:id])
    end

    # def launch_params
    #   params.require(:launch).permit(:payload)
    # end

    def find_credential
      raise "No LTI key" unless params["oauth_consumer_key"].present?
      if @credential = Credential.find_by(consumer_key: params["oauth_consumer_key"])
        @credential.enabled? ? @credential : (raise "Credential is disabled")
      else
        raise "Unknown LTI Key"
      end
    end

    def find_or_create_user
      @user = User.find_or_create_by(lti_user_id: params["user_id"]) do |u|
        u.preferred_name = params["lis_person_name_given"]
      end
    end

    def find_or_create_resource_context

      if @resource = Resource.find_by(lti_resource_link_id: params["resource_link_id"])
        @resource
        @context = @resource.context
      elsif (params["roles"].split(",") & %w(Instructor Teachingassistant)).any? # Checks if current user is Instructor or Teachingassistant
        @resource = Resource.find_or_create_by(lti_resource_link_id: params["resource_link_id"]) do |r|
          r.lis_outcome_service_url = params["lis_outcome_service_url"]

          r.context = Context.find_or_create_by(lti_context_id: params["context_id"]) do |c|
            c.credential = @credential
            c.title      = params["context_title"]
          end
        end
        @context = @resource.context
      else
        redirect_to root_url,
        notice: "Attendance assignment has not been created yet"
      end
    end

    def teacher?
      (params["roles"].split(",") & %w(Instructor Teachingassistant)).any?
    end

    def learner?
      (params["roles"].split(",") & %w(Learner)).any?
    end

    def find_resource_and_context
      @resource = Resource.find_by(lti_resource_link_id: params["resource_link_id"])
      @context = Context.find_by(lti_context_id: params["context_id"])
    end

    def find_or_create_enrollment
      @enrollment = Enrollment.find_or_create_by(user: @user, context: @context) do |e|
        e.roles = params["roles"]
      end
    end

    def set_current_enrollment
      session[:enrollment_id] = @enrollment.id
    end
end
