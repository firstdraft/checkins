class SubmissionsController < ApplicationController
  before_action :set_submission

  def resubmit
    authorize @submission
    @submission.pass_back_grade

    redirect_to resource_url(@submission.resource), notice: "Grade was
      successfully resubmitted"
  end

  private

  def set_submission
    @submission = Submission.find(params[:id])
  end
end
