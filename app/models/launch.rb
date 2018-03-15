class Launch < ApplicationRecord
  belongs_to :credential
  belongs_to :enrollment


  def resource
    Resource.find_by(lti_resource_link_id: self.payload["resource_link_id"])
  end
end
