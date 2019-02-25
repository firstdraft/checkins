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
  belongs_to :resource
  has_many   :attendances, dependent: :destroy
  has_many   :check_ins

  has_one :context, through: :resource

  scope :by_date, ->(date) { where(start_time: date.midnight..date.end_of_day) }
  scope :gradeable, -> { where("start_time <= ?", DateTime.now + 1.hour) }

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
end
