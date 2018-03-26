# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
#  date        :date
#  start_time  :time
#  end_time    :time
#  resource_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Meeting < ApplicationRecord
  belongs_to :resource
end
