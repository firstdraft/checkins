class CheckIn < ApplicationRecord
  belongs_to :enrollment

  has_one :user, through: :enrollment, source: :user

  def resource
    @resource = Resource.find_by(id: self.resource_id)
  end
end
