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
#  starts_on               :date
#  ends_on                 :date
#  days_of_week            :string           is an Array
#

class Resource < ApplicationRecord
  after_update :create_meetings

  belongs_to :context
  has_many :enrollments, dependent: :destroy
  has_many :meetings, dependent: :destroy

  validate :must_have_schedule, on: :update
  validate :starts_on_earlier_than_ends_on, on: :update

  def must_have_schedule
    if starts_on.blank? || ends_on.blank? || days_of_week.blank?
      errors.add(:base, "You have to provide a schedule")
    end
  end

  def starts_on_earlier_than_ends_on
    if starts_on && ends_on && starts_on > ends_on
      errors.add(:base, "Start date must be earlier than end date")
    end
  end

  def meets_today?
    # returns true or false
  end

  def all_occurrences
    # returns an array of Date
    date_range = (starts_on..ends_on).to_a
    occurrences = []

    date_range.each do |date|
      if date.wday.to_s.in?(days_of_week)
        occurrences << date
      end
    end
    occurrences
  end


  def create_meetings
    all_occurrences.each do |date|
      m = meetings.new(start_time: Chronic.parse(date.to_s + " " + "14:35"), end_time: Chronic.parse(date.to_s + " " + "17:35"))
      m.save
    end
  end
end
