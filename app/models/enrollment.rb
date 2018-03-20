# == Schema Information
#
# Table name: enrollments
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  roles      :string
#  user_id    :integer
#  context_id :integer
#

class Enrollment < ApplicationRecord
  belongs_to :context
  belongs_to :user

  has_many :launches
  has_many :check_ins, dependent: :destroy
end
