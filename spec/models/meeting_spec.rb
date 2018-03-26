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

require 'rails_helper'

RSpec.describe Meeting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
