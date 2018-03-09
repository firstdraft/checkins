class CheckIn < ApplicationRecord
  belongs_to :enrollment

  has_one :user, through: :enrollment, source: :user

end
