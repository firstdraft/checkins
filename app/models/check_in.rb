# == Schema Information
#
# Table name: check_ins
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  present       :boolean          default(TRUE)
#  late          :boolean
#  enrollment_id :integer
#  approved      :boolean          default(FALSE)
#  latitude      :float
#  longitude     :float
#  meeting_id    :integer
#

class CheckIn < ApplicationRecord
  after_create :set_approved

  belongs_to :enrollment
  belongs_to :meeting

  has_one :user, through: :enrollment, source: :user
  has_one :resource, through: :meeting

  scope :approved, -> { where(approved: true) }

  def set_approved
      update(approved: (created_at > (meeting.start_time - 3600) && created_at < (meeting.end_time)))
  end

end
