# == Schema Information
#
# Table name: enrollments
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  roles      :string
#  user_id    :integer
#  context_id :integer
#

class Enrollment < ApplicationRecord
  belongs_to :context
  belongs_to :user

  has_many :launches
  has_many :check_ins, dependent: :destroy


  def latest_launch
    launches.order(:created_at).last
  end

  def resource
    Resource.find_by(lti_resource_link_id: latest_launch.payload["resource_link_id"])
  end

  def count_of_meetings_checked_into
    # check_ins.approved.map { |check_in| check_in.meeting}.uniq.count
    # The above line was causing a weird error where it was saying that eager loading was detected. I don't know why that would casue an error though. The below commented line below works.
    # check_ins.approved.includes(:meeting).map { |check_in| check_in.meeting}.uniq.count
    check_ins.approved.pluck(:meeting_id).uniq.count
  end

  def count_of_gradeable_meetings
    resource.meetings.gradeable.count
  end

  def grade_attendance
    if count_of_gradeable_meetings != 0
      count_of_meetings_checked_into.to_f / count_of_gradeable_meetings.to_f
    else
      1.to_f
    end
  end
end
