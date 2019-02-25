# frozen_string_literal: true

# == Schema Information
#
# Table name: contexts
#
#  id             :bigint(8)        not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  title          :string
#  lti_context_id :string
#  credential_id  :integer
#

class Context < ApplicationRecord
  belongs_to :credential

  has_many :resources, dependent: :destroy
  has_many :enrollments, dependent: :destroy

  has_many :meetings, through: :resources
  has_many :submissions, through: :resources
  has_many :attendances, through: :resources

  has_one :administrator, through: :credential, source: :administrator
end
