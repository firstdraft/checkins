# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_enrollment
  helper_method :current_user
  helper_method :current_resource
  helper_method :current_context
  helper_method :current_launch

  def landing
    render "/landing.html.erb"
  end

  def current_enrollment
    @current_enrollment ||= Enrollment.find_by(id: session[:enrollment_id])
  end

  def current_submission
    @current_submission ||= Submission.find_by(id: session[:submission_id])
  end

  def current_user
    current_enrollment.user
  end

  def current_credential
    current_enrollment.context.credential
  end

  def current_launch
    Launch.find_by(id: session[:launch_id])
  end

  def current_resource
    Resource.find_by(id: session[:resource_id])
  end

  def current_context
    current_resource.context
  end

  def authorize_lti_user
    redirect_to landing_url if current_enrollment.nil?
  end
end
