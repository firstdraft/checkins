# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
#  start_time  :datetime
#  end_time    :datetime
#  resource_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Meeting < ApplicationRecord
  belongs_to :resource
end
