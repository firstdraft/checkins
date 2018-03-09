class Enrollment < ApplicationRecord
  belongs_to :context
  belongs_to :user

  has_many :launches
  has_many :check_ins, dependent: :destroy
end
