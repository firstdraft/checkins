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
#  resource_id   :integer
#  approved      :boolean          default(FALSE)
#

class CheckIn < ApplicationRecord
  after_create :set_approved

  belongs_to :enrollment
  belongs_to :resource

  has_many :meetings, through: :resource
  has_one :user, through: :enrollment, source: :user

  scope :approved, -> { where(approved: true) }


  def target_meetings
    meetings.by_date(created_at)
  end

  def set_approved
    if target_meetings.any?
      update(approved: (created_at > (target_meetings.first.start_time - 3600) && created_at < (target_meetings.first.end_time)))
    end
  end

end
