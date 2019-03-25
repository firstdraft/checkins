# == Schema Information
#
# Table name: attendances
#
#  id            :bigint(8)        not null, primary key
#  checked_in_at :datetime
#  latitude      :float
#  longitude     :float
#  status        :string           not null
#  meeting_id    :bigint(8)
#  submission_id :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (submission_id => submissions.id)
#

class Attendance < ApplicationRecord
  include AASM
  has_paper_trail
  after_save :update_submission

  belongs_to :meeting
  belongs_to :submission

  has_one :context, through: :resource
  has_one :enrollment, through: :submission
  has_one :resource, through: :submission
  has_one :user, through: :enrollment

  scope :accepted, -> { where(status: "accepted") }
  scope :for, ->(submission) { find_by(submission: submission) }

  validates_uniqueness_of :submission,
                          scope: :meeting,
                          message: "already exists for the associated meeting"

  aasm column: "status" do
    state :pending, initial: true
    state :not_accepted, :in_appeal, :accepted

    event :check_in do
      before do
        assign_attributes(checked_in_at: Time.current)
      end

      transitions from: :pending, to: :accepted, if: :passes_verifications?
      transitions from: :pending, to: :not_accepted
    end

    event :mark_absent do
      transitions from: :pending, to: :not_accepted, if: :meeting_complete?
    end

    event :appeal do
      transitions from: :not_accepted, to: :in_appeal
    end

    event :approve do
      before do
        assign_attributes(checked_in_at: Time.current) if checked_in_at == nil
      end
      transitions from: %i[in_appeal not_accepted pending], to: :accepted
    end

    event :deny do
      transitions from: %i[in_appeal accepted pending], to: :not_accepted
    end

    event :reset do
      before do
        assign_attributes(checked_in_at: nil)
      end
      transitions from: %i[accepted in_appeal not_accepted], to: :pending
    end
  end

  def within_allowed_timeframe?
    checked_in_at&.between?(meeting.start_time - 1.hour, meeting.end_time)
  end

  def meeting_complete?
    meeting.complete?
  end

  def passes_verifications?
    within_allowed_timeframe?
  end

  def self.teacher_events
    %i[approve deny reset]
  end

  def self.student_events
    %i[check_in appeal]
  end

  def allowed_events
    aasm.events.map(&:name)
  end

  def update_submission
    submission.update_score
  end
end
