# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  roles      :string
#  user_id    :integer
#  context_id :integer
#

class Enrollment < ApplicationRecord
  belongs_to :context
  belongs_to :user
  has_many :launches
  has_many :submissions, dependent: :destroy

  has_many :attendances, through: :submissions
  has_many :resources, through: :submissions

  validates :user,
            uniqueness: {
              scope: :context,
              message: "already exists for context",
            }

  def latest_launch
    launches.order(:created_at).last
  end

  def resource
    Resource.find_by(lti_resource_link_id: latest_launch.payload["resource_link_id"])
  end

  def teacher?
    roles.downcase.include?("teachingassistant") || roles.downcase.include?("instructor")
  end
end
