# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  first_name     :string
#  last_name      :string
#  preferred_name :string
#  lti_user_id    :string
#

class User < ApplicationRecord
  has_many :enrollments, dependent: :destroy

  has_many :check_ins, through: :enrollments
  has_many :contexts, through: :enrollments
  has_many :launches, through: :enrollments

  validates :preferred_name, presence: true

end
