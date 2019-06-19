class AttendancesController < ApplicationController
  skip_after_action :verify_authorized

  def transition
    @attendance = Attendance.find(params[:attendance_id])
    event = params.fetch(:event).to_sym
    authorize @attendance, event

    if @attendance.aasm.events.map(&:name).include?(event) &&
        @attendance.send(event)
      @attendance.save
    end
    request.variant = if current_enrollment.teacher?
                        :teacher
                      else
                        :student
                      end

    @meeting = @attendance.meeting
  end
end
