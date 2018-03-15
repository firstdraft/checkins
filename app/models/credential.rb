class Credential < ApplicationRecord
  belongs_to :administrator

  has_many :contexts, dependent: :destroy
  has_many :launches

  scope :enabled, -> { where(enabled: true) }

  has_secure_token :consumer_key
  has_secure_token :consumer_secret
end
