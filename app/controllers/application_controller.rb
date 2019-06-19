# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  after_action :verify_authorized,
               except: %i[index landing],
               unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :current_context
  helper_method :current_enrollment
  helper_method :current_launch
  helper_method :current_resource
  helper_method :current_submission
  helper_method :current_user
  helper_method :pundit_user

  before_action :set_paper_trail_whodunnit

  def landing
    render "/landing.html.erb"
  end

  def current_enrollment
    @current_enrollment ||= Enrollment.find_by(id: session[:enrollment_id])
  end

  def pundit_user
    current_enrollment
  end

  def current_submission
    @current_submission ||= Submission.find_by(id: session[:submission_id])
  end

  def current_user
    current_enrollment.try(:user)
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

def user_not_authorized
  flash[:warning] = "You are not authorized to perform this action."
  redirect_to(request.referrer || root_path)
end
