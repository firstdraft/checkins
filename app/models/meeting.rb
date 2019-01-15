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
  has_many   :check_ins
  scope :by_date, -> (date) { where(start_time: date.midnight..date.end_of_day) }
  scope :gradeable, -> { where('start_time <= ?', DateTime.now + 1.hour)}


  def has_approved_check_in?(enrollment)
    check_ins = enrollment.check_ins.approved
  # find a check_in that has this meeting in its target_meetings
    result = false

    check_ins.each do |c|
      if self.in?(c.target_meetings)
        result = true
      end
    end
    result
  end


end
