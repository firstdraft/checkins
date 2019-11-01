# frozen_string_literal: true

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
  
require 'rails_helper'

RSpec.describe Meeting, type: :model do
  # where(Meeting.arel_table[:start_time].lteq(Time.current + 1.hour))
  before do
    p Time.now
    Timecop.freeze(Time.current.at_end_of_day)
    p Time.now

  end

  after do
    Timecop.return
  end
  it "returns all Meetings that are gradeable" do
    admin = create(:administrator)
    credential = create(:credential, administrator: admin)
    context = create(:context, credential: credential)
    resource = create(:resource, monday: true, context: context)
    meeting_1 = create(:meeting, resource: resource, start_time: Time.current.at_noon)
    meeting_2 = create(:meeting, resource: resource)
    meeting_3 = create(:meeting, resource: resource)
    
    expect(Meeting.gradeable).to_not include(meeting_2, meeting_3)
    expect(Meeting.gradeable).to include(meeting_1)
  end
end
