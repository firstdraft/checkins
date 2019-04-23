class AttendancesController < ApplicationController
  def transition
    @attendance = Attendance.find(params[:attendance_id])
    event = params.fetch(:event).to_sym

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
