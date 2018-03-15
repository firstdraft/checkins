class User < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :check_ins, through: :enrollments

  has_many :contexts, through: :enrollments
  has_many :launches, through: :enrollments


  def enrollment_check_ins(enrollment_id)
    self.enrollments.find(enrollment_id).check_ins
  end
end
