# frozen_string_literal: true

# == Schema Information
#
# Table name: check_ins
#
#  id            :bigint(8)        not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  present       :boolean          default(TRUE)
#  late          :boolean
#  approved      :boolean          default(FALSE)
#  latitude      :float
#  longitude     :float
#  meeting_id    :bigint(8)
#  submission_id :bigint(8)
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (submission_id => submissions.id)
#

class CheckIn < ApplicationRecord
  after_create :update_approved
  after_save   :update_submission

  belongs_to :submission
  belongs_to :meeting

  has_one :enrollment, through: :submission
  has_one :user, through: :submission
  has_one :resource, through: :meeting

  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }
  scope :for, ->(submission) { where(submission: submission) }

  def to_s
    created_at.strftime("%a %-m/%-e,  %l:%M %P").to_s
  end

  def within_allowed_timeframe?
    created_at.between?(meeting.start_time - 1.hour, meeting.end_time)
  end

  def update_approved
    update(approved: within_allowed_timeframe?) unless approved?
  end

  def update_submission
    submission.update_score
  end
end
