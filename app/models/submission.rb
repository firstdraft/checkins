# frozen_string_literal: true

# == Schema Information
#
# Table name: submissions
#
#  id            :bigint(8)        not null, primary key
#  enrollment_id :bigint(8)
#  resource_id   :bigint(8)
#  score         :float            default(0.0)
#
# Foreign Keys
#
#  fk_rails_...  (enrollment_id => enrollments.id)
#  fk_rails_...  (resource_id => resources.id)
#

class Submission < ApplicationRecord
  after_create :create_attendances
  after_update :pass_back_grade

  belongs_to :resource
  belongs_to :enrollment
  has_many   :check_ins
  has_many   :attendances, dependent: :destroy

  has_many   :meetings, through: :resource

  has_many :gradeable_meetings, -> { gradeable }, through: :resource, source: :meetings
  has_many :approved_check_ins, -> { approved }, class_name: "CheckIn"
  has_many :approved_meetings, -> { distinct }, through: :approved_check_ins, source: :meeting

  has_one    :user, through: :enrollment
  has_one    :context, through: :resource

  validates :enrollment,
            uniqueness: {
              scope: :resource,
              message: "already exists for resource"
            }

  def pass_back_grade
    provider = IMS::LTI::ToolProvider.new(
      context.credential.consumer_key,
      context.credential.consumer_secret,
      enrollment.launches.last.payload,
    )

    provider.post_replace_result!(score) if provider.outcome_service?
  end

  def compute_score
    if gradeable_meetings.any?
      (approved_meetings.count.to_f / gradeable_meetings.count).round(4)
    else
      1.0
    end
  end

  def update_score
    update(score: compute_score) if score.round(4) != compute_score
  end

  def full_user_name
    "#{user.preferred_name} #{user.last_name}".strip
  end

  def create_attendances
    resource.meetings.each do |meeting|
      attendances.create(meeting: meeting)
    end
  end
end
