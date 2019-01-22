# == Schema Information
#
# Table name: check_ins
#
#  id            :bigint(8)        not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  present       :boolean          default(TRUE)
#  late          :boolean
#  enrollment_id :integer
#  approved      :boolean          default(FALSE)
#  latitude      :float
#  longitude     :float
#  meeting_id    :bigint(8)
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#

class CheckIn < ApplicationRecord
  after_create :set_approved

  belongs_to :enrollment
  belongs_to :meeting

  has_one :user, through: :enrollment, source: :user
  has_one :resource, through: :meeting

  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false)}

  def within_allowed_timeframe?
    created_at.between?(meeting.start_time - 1.hour, meeting.end_time)
  end

  def set_approved
      update(approved: within_allowed_timeframe?)
  end

end
