# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id             :bigint(8)        not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  first_name     :string
#  last_name      :string
#  preferred_name :string
#  lti_user_id    :string
#

class User < ApplicationRecord
  has_many :enrollments, dependent: :destroy

  has_many :attendances, through: :enrollments
  has_many :contexts, through: :enrollments
  has_many :launches, through: :enrollments
  has_many :resources, through: :enrollments
  has_many :submissions, through: :enrollments
  has_many :check_ins, through: :submissions

  validates :preferred_name, presence: true
  validates :lti_user_id, uniqueness: true
end
