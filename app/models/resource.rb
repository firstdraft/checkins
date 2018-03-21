# == Schema Information
#
# Table name: resources
#
#  id                      :integer          not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  meeting_schedule_hash   :string
#  lis_outcome_service_url :string
#  lti_resource_link_id    :string
#  context_id              :integer
#

class Resource < ApplicationRecord
  belongs_to :context
  has_many :enrollments, dependent: :destroy
end
