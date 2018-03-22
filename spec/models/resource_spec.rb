# == Schema Information
#
# Table name: resources
#
#  id                      :integer          not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  meeting_schedule_hash   :string
#  lis_outcome_service_url :string
#  lti_resource_link_id    :string
#  context_id              :integer
#  starts_on               :date
#  ends_on                 :date
#  days_of_week            :string
#

describe "#all_occurrences" do
  it "returns an array of dates" do
    resource = Resource.new

    resource.starts_on = blah
    resource.ends_on = blah
    resource.days_of_week = blah
    resource.starts_on = blah

    expect(resource.all_occurrences).to eq(some_array)
  end
end
