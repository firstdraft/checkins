# frozen_string_literal: true

# == Schema Information
#
# Table name: contexts
#
#  id               :bigint(8)        not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  title            :string
#  lti_context_id   :string
#  credential_id    :integer
#  allowed_absences :integer          default(0)
#

class Context < ApplicationRecord
  after_update :update_submissions

  belongs_to :credential

  has_many :resources, dependent: :destroy
  has_many :enrollments, dependent: :destroy

  has_many :meetings, through: :resources
  has_many :submissions, through: :resources
  has_many :attendances, through: :resources

  has_one :administrator, through: :credential, source: :administrator

  validates :lti_context_id, uniqueness: true
  validates :allowed_absences, presence: true
  validates :allowed_absences,
            numericality: { only_integer: true, message: "must be an integer." }
  validates :allowed_absences, numericality: { greater_than_or_equal_to: 0 }

  def update_submissions
    submissions.each(&:update_score)
  end
end
