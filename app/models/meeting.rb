# frozen_string_literal: true

# == Schema Information
#
# Table name: meetings
#
#  id          :bigint(8)        not null, primary key
#  start_time  :datetime
#  end_time    :datetime
#  resource_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Meeting < ApplicationRecord
  after_create :create_attendances

  belongs_to :resource
  has_many   :attendances, dependent: :destroy
  has_many   :check_ins

  has_one :context, through: :resource

  scope :by_date, ->(date) { where(start_time: date.midnight..date.end_of_day) }
  scope :gradeable, -> {
    where(Meeting.arel_table[:start_time].lteq(Time.current + 1.hour))
  }
  scope :finished, -> { where("end_time <= ?", Time.current) }

  validate :start_time_earlier_than_end_time
  validate :after_resource_start
  validate :before_resource_end

  def start_time_earlier_than_end_time
    if start_time > end_time
      errors.add(:base, "Start time must be earlier than end time")
    end
  end

  def after_resource_start
    if start_time < resource.starts_on
      errors.add(:base, "Meeting must start after its Resource's start date (#{resource.starts_on})")
    end
  end

  def before_resource_end
    if start_time.to_date > resource.ends_on
      errors.add(:base, "Meeting must start before its Resource's end date (#{resource.ends_on})")
    end
  end

  def has_approved_check_in?(enrollment)
    check_ins = enrollment.check_ins.approved
    # find a check_in that has this meeting in its target_meetings
    result = false

    check_ins.each do |c|
      result = true if in?(c.target_meetings)
    end
    result
  end

  def to_s
    start_time.to_date.strftime("%a %-m/%-d/%y")
  end

  def gradeable?
    start_time <= Time.now + 1.hour
  end

  def complete?
    end_time <= Time.current
  end

  def create_attendances
    resource.submissions.each do |submission|
      submission.attendances.create(meeting: self)
    end
  end

  def attendance_for(submission)
    attendances.find_by(submission: submission)
  end
end
