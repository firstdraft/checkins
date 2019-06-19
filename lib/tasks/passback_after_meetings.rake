desc "Mark all pending attendances for finished meetings as absent"
task mark_past_due_pending_attendances_not_approved: :environment do
  past_due_pending_attendances = Attendance.pending.joins(:meeting).
    merge(Meeting.finished)

  past_due_pending_attendances.each(&:mark_absent!)
end
