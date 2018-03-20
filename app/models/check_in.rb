# == Schema Information
#
# Table name: check_ins
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  present       :boolean          default(TRUE)
#  late          :boolean
#  enrollment_id :integer
#  resource_id   :integer
#

class CheckIn < ApplicationRecord
  belongs_to :enrollment

  has_one :user, through: :enrollment, source: :user

  def resource
    @resource = Resource.find_by(id: self.resource_id)
  end
end
