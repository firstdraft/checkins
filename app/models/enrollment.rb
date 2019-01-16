# == Schema Information
#
# Table name: enrollments
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  roles       :string
#  user_id     :integer
#  resource_id :bigint(8)
#
# Foreign Keys
#
#  fk_rails_...  (resource_id => resources.id)
#

class Enrollment < ApplicationRecord
  belongs_to :resource
  belongs_to :user
  has_one :context, through: :resource

  has_many :launches
  has_many :check_ins, dependent: :destroy
  has_many :approved_check_ins, -> { approved }, class_name: "CheckIn"
  has_many :approved_meetings, -> { distinct }, through: :approved_check_ins, source: :meeting

  def latest_launch
    launches.order(:created_at).last
  end

  def count_of_gradeable_meetings
    resource.meetings.gradeable.count
  end

  def grade_attendance
    if count_of_gradeable_meetings != 0
      approved_meetings.count.to_f / count_of_gradeable_meetings.to_f
    else
      1.to_f
    end
  end

  def teacher?
    roles.downcase.include?("teachingassistant") || roles.downcase.include?("instructor")
  end
end
