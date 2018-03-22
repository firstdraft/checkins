# == Schema Information
#
# Table name: resources
#
#  id                      :integer          not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  meeting_schedule_hash   :string
#  lis_outcome_service_url :string
#  lti_resource_link_id    :string
#  context_id              :integer
#

class Resource < ApplicationRecord
  belongs_to :context
  has_many :enrollments, dependent: :destroy

  # add a column starts_on
  # add a column ends_on
  # add a column days_of_week

  validate :must_have_schedule, on: :update

  def must_have_schedule
    if starts_on.blank? || ends_on.blank? || days_of_week.blank?
      errors.add(:base, "You have to provide a schedule")
    end
  end

  def meets_today?
    # returns true or false
  end

  def all_occurrences
    # returns an array of Date
  end

  after_update :create_meetings

  def create_meetings

  end
end
