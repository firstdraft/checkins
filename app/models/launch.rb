# frozen_string_literal: true

# == Schema Information
#
# Table name: launches
#
#  id            :bigint(8)        not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  payload       :jsonb
#  enrollment_id :integer
#  credential_id :integer
#

class Launch < ApplicationRecord
  belongs_to :credential
  belongs_to :enrollment

  has_one :user, through: :enrollment

  def resource
    Resource.find_by(lti_resource_link_id: payload["resource_link_id"])
  end
end
