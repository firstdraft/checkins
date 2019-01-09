tues = Resource.find(6)
weds = Resource.find(8)
thurs = Resource.find(9)
tues_meetings = tues.meetings
weds_meetings = weds.meetings
thurs_meetings = thurs.meetings
tues_first_meeting = tues_meetings.order(:start_time).first
weds_first_meeting = weds_meetings.order(:start_time).first
thurs_first_meeting = thurs_meetings.order(:start_time).first


enrollments = Enrollment.where(roles:"Learner", context_id:4)
check_ins = CheckIn.where(resource_id: [6,8,9])
thanksgiving = Date.new(2018,11,22)
first_week = Date.new(2018,10,2).cweek
tweek_meetings = Meeting.select { |m| m.start_time.to_date.cweek == thanksgiving.cweek }
first_week_check_ins = check_ins.select { |c| c.updated_at.to_date.cweek == first_week}
approved_first_week_check_ins = first_week_check_ins.select { |c| c.approved }

initial_grades_hash = {}

enrollments.each do |e|
  initial_grades_hash[e.id] = e.grade_attendance
end

updated_grades_hash = {}

enrollments.each do |e|
  updated_grades_hash[e.id] = e.grade_attendance
end

grades_comparison = {}

enrollments.each do |e|
  grades_comparison[e.id] = {
    initial: initial_grades_hash[e.id],
    updated: updated_grades_hash[e.id]
  }
end

grades_comparison.each do |k,v|
  p (v[:updated] - v[:initial])
  # p {k => (v[:initial] <= v[:updated])}
end

# initial_grades_hash for record
# {179=>0.2222222222222222, 180=>1.0, 181=>0.7777777777777778, 182=>0.6666666666666666, 183=>1.0, 184=>1.0, 185=>0.8888888888888888, 186=>0.8888888888888888, 187=>0.8888888888888888, 188=>1.0, 189=>0.7777777777777778, 190=>1.0, 191=>1.0, 192=>0.8888888888888888, 193=>1.0, 194=>0.8888888888888888, 195=>1.0, 196=>0.7777777777777778, 197=>0.8888888888888888, 198=>0.4444444444444444, 199=>0.7777777777777778, 200=>0.8888888888888888, 201=>1.0, 202=>0.8888888888888888, 203=>0.8888888888888888, 204=>0.4444444444444444, 205=>0.8888888888888888, 206=>1.0, 207=>0.8888888888888888, 209=>0.8888888888888888, 210=>1.0, 211=>0.8888888888888888, 212=>0.8888888888888888, 213=>0.8888888888888888, 214=>0.8888888888888888, 215=>0.7777777777777778, 216=>1.0, 217=>0.7777777777777778, 218=>0.8888888888888888, 219=>1.0, 220=>0.7777777777777778, 221=>0.7777777777777778, 222=>1.0, 223=>1.0, 224=>0.2222222222222222, 225=>0.7777777777777778, 226=>0.6666666666666666, 227=>1.0, 228=>0.8888888888888888, 229=>0.8888888888888888, 230=>0.8888888888888888, 231=>1.0, 232=>0.6666666666666666, 233=>0.6666666666666666, 234=>0.8888888888888888, 235=>0.7777777777777778, 236=>0.8888888888888888, 237=>1.0, 238=>0.5555555555555556, 239=>0.0, 240=>0.875, 241=>0.875, 242=>0.875, 243=>0.125, 244=>0.5, 245=>0.875, 246=>0.75, 247=>0.875, 248=>0.875, 249=>0.875, 250=>0.875, 251=>0.125, 252=>0.875, 253=>0.875, 254=>0.875, 255=>0.875, 256=>0.875, 257=>0.875, 258=>0.875, 259=>0.125, 260=>0.125, 261=>0.875, 262=>0.125, 263=>0.75, 264=>0.75, 265=>0.875, 266=>0.5, 267=>0.625, 268=>0.75, 299=>0.625}


[#<Meeting id: 57, start_time: "2018-11-20 19:30:00", end_time: "2018-11-20 22:30:00", resource_id: 6, created_at: "2018-10-02 15:31:02", updated_at: "2018-10-02 15:31:02">, #<Meeting id: 67, start_time: "2018-11-22 00:00:00", end_time: "2018-11-22 03:00:00", resource_id: 8, created_at: "2018-10-03 22:43:46", updated_at: "2018-10-03 22:43:46">, #<Meeting id: 76, start_time: "2018-11-22 19:30:00", end_time: "2018-11-22 22:30:00", resource_id: 9, created_at: "2018-10-11 18:24:09", updated_at: "2018-10-11 18:24:09">]

first_week_check_ins.each do |c|
  c.destroy
end

def mode(array)
  current_mode = array.first
  array.each do |i|
    current_mode = i if array.count(i) > array.count(current_mode)
  end
  current_mode
end

hash = {}
enrollment_resource_hash ={}
new_check_ins = []
enrollments.each do |e|
  hash[e.id] = mode(e.check_ins.map { |c| c.resource_id})
  # enrollment_resource_hash[e] = mode(e.check_ins.map { |c| c.resource})
  resource = mode(e.check_ins.map { |c| c.resource})
  new_check_ins << e.check_ins.build(resource:resource,approved:true) if resource!=nil
end

new_check_ins.each do |c|
  if c.save
    check_in_time = c.resource.meetings.order(:start_time).first.start_time
    # c.assign_attributes(created_at: check_in_time, updated_at: check_in_time)
    c.update_attributes(created_at: check_in_time, updated_at: check_in_time)
  end
end




# ===========================================================================================
#                 Code for transmitting new grades to Canvas
# ===========================================================================================

cred = Credential.first
enrollments.each do |e|
  if resource = mode(e.check_ins.map { |c| c.resource})
    launch = e.launches.select { |l| l.payload["resource_link_id"] == resource.lti_resource_link_id }.last

    count_of_gradeable_meetings = resource.meetings.gradeable.count
    grade = e.count_of_meetings_checked_into.to_f / count_of_gradeable_meetings

    provider = IMS::LTI::ToolProvider.new(
      cred.consumer_key,
      cred.consumer_secret,
      launch.payload
    )

    response = provider.post_replace_result!(grade)
  end
end



# ===========================================================================================
#                 Code to update a set of users with first and last names from launches
# ===========================================================================================

users.each do |user|
  launch = user.launches.first
  first = launch.payload["lis_person_name_given"]
  last = launch.payload["lis_person_name_family"]
  user.update_attributes(first_name: first, last_name: last)
end
