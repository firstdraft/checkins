class AttendancesController < ApplicationController
  def transition
    attendance = Attendance.find(params[:attendance_id])
    event = params.fetch(:event).to_sym

    if attendance.aasm.events.map(&:name).include?(event) &&
        attendance.send(event)
      attendance.save
    end

    redirect_to resource_path(attendance.resource)
  end
end
