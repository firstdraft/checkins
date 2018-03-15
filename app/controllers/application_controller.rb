class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_enrollment
  helper_method :current_user

  def current_enrollment
    @current_enrollment ||= Enrollment.find_by(id:session[:enrollment_id])
  end

  def current_user
    current_enrollment.user
  end
end
