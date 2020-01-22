# frozen_string_literal: true

class LaunchesController < ApplicationController
  before_action :set_launch, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def xml_config
    respond_to do |format|
      format.xml do
        tool_config = IMS::LTI::ToolConfig.new(
          title: "First Draft Checkins",
          launch_url: launch_url,
        )

        tool_config.description = "This LTI Tool grades attendance"

        render xml: tool_config.to_xml
      end
    end
  end

  def create
    find_credential
    find_resource_and_context
    if @resource && @context
      find_or_create_user
      find_or_create_enrollment
      set_current_enrollment
      find_or_create_submission
      set_current_submission
      @launch = Launch.new(payload: params, credential: @credential, enrollment: @enrollment)
      if @launch.save
        set_current_launch
        set_current_resource
        if learner?
          redirect_to resource_url(@resource)
        elsif teacher?
          redirect_to resource_url(@resource)
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
      find_or_create_submission
      set_current_submission
      @launch = Launch.new(payload: params, credential: @credential, enrollment: @enrollment)
      if @launch.save
        set_current_launch
        set_current_resource
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

  private

  def set_launch
    @launch = Launch.find(params[:id])
  end

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
      u.first_name = params["lis_person_name_given"]
      u.last_name = params["lis_person_name_family"]
    end
  end

  def find_or_create_resource_context
    if @resource = Resource.find_by(lti_resource_link_id: params["resource_link_id"])
      @resource
      @context = @resource.context
    elsif (params["roles"].split(",") & %w[Instructor Teachingassistant]).any? # Checks if current user is Instructor or Teachingassistant
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

  def find_or_create_submission
    @submission = Submission.find_or_create_by(
      resource: @resource,
      enrollment: @enrollment,
    )
  end

  def parsed_roles
    raw = params["roles"].split(",")
    roles = raw.map do |r|
      r.split("/").last.downcase
    end
    roles
  end

  def teacher?
    (parsed_roles & %w[instructor teachingassistant]).any?
  end

  def learner?
    (parsed_roles & %w[learner]).any?
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

  def set_current_submission
    session[:submission_id] = @submission.id
  end

  def set_current_launch
    session[:launch_id] = @launch.id
  end

  def set_current_resource
    session[:resource_id] = @resource.id
  end
end
