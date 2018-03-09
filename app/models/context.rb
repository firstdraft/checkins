class Context < ApplicationRecord

  belongs_to :credential

  has_many :resources, dependent: :destroy

  has_one :administrator, through: :credential, source: :administrator
end
