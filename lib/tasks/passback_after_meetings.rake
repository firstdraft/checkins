desc "Mark all pending attendances for finished meetings as absent"
task mark_absent_attendances: :environment do
  res = Arel::Table.new(:resources)
  query = res[:starts_on].lteq(Date.current).
    and(res[:ends_on].gteq(Date.current))
  active_resources = Resource.where(query)

  finished_meetings = Meeting.where(resource: active_resources).finished

  pending_attendances = Attendance.where(meeting: finished_meetings).pending

  pending_attendances.each(&:mark_absent!)
end
