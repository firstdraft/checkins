class Resource < ApplicationRecord
  belongs_to :context
  has_many :enrollments, dependent: :destroy
end
