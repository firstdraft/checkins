# == Schema Information
#
# Table name: credentials
#
#  id               :bigint(8)        not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  consumer_key     :string
#  consumer_secret  :string
#  administrator_id :integer
#  enabled          :boolean          default(TRUE)
#

class Credential < ApplicationRecord
  belongs_to :administrator

  has_many :contexts, dependent: :destroy
  has_many :launches

  scope :enabled, -> { where(enabled: true) }

  has_secure_token :consumer_key
  has_secure_token :consumer_secret
end
