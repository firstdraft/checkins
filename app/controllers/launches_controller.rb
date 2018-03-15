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

  def create
    find_credential
    find_or_create_user
    find_or_create_resource_context
    set_current_enrollment

    provider = IMS::LTI::ToolProvider.new(
        @credential.consumer_key,
        @credential.consumer_secret,
        params
      )

    @launch = Launch.new(payload:params, credential:@credential, enrollment:@enrollment)
    # @enrollments = @user.enrollments

    p "========================================================================"
    # p provider.outcome_service?

    p "========================================================================"
    # p provider.post_replace_result!(0.6)                #RETURNS AN OutcomeResponse OBJECT
    # p provider.post_replace_result!(0.6).description    #RETURNS "Your old score of 0 has been replaced with 0.6"
    p "========================================================================"

    if @launch.save
      if (@enrollment.roles.split(",") & %w(Learner)).any?
        redirect_to resource_url(@resource)
      elsif @user.teacher?
        redirect_to @launch
      end
    end
  end

  def edit
  end

  def update
    @launch = Launch.find(params.fetch("id_to_modify"))

    @launch.payload = params.fetch("payload")
    @launch.enrollment_id = params.fetch("enrollment_id")
    @launch.credential_id = params.fetch("credential_id")

    if @launch.valid?
      @launch.save

      redirect_to("/launches/#{@launch.id}", :notice => "Launch updated successfully.")
    else
      render("launch_templates/edit_form.html.erb")
    end
  end

  def destroy
    @launch = Launch.find(params.fetch("id_to_remove"))

    @launch.destroy

    redirect_to("/launches", :notice => "Launch deleted successfully.")
  end

  private

  def set_launch
    @launch = Launch.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
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
      redirect_to root,
      notice: "Attendance assignment has not been created yet"
    end
  end

  def set_current_enrollment
    @enrollment = Enrollment.find_or_create_by(user: @user, context: @context) do |e|
      e.roles = params["roles"]
    end
    session[:enrollment_id] = @enrollment.id
  end

end
