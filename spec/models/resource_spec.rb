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
#  days_of_week            :string           is an Array
#

describe "#all_occurrences" do

  it "returns an array" do
    resource = Resource.new
    starts = Date.new(2018,1,1)
    ends = Date.new(2018,1,31)
    mondays = [starts, starts + 7, starts + 14, starts + 21, starts + 28]

    resource.starts_on = starts
    resource.ends_on = ends
    resource.days_of_week = [1]

    expect(resource.all_occurrences.class).to eq(Array)
  end

  it "returns an array of dates" do
    resource = Resource.new
    starts = Date.new(2018,1,1)
    ends = Date.new(2018,1,31)
    mondays = [starts, starts + 7, starts + 14, starts + 21, starts + 28]

    resource.starts_on = starts
    resource.ends_on = ends
    resource.days_of_week = [1]

    expect(resource.all_occurrences.sample.class).to eq(Date)
  end

  it "returns the correct occurrences" do
    resource = Resource.new
    starts = Date.new(2018,1,1)
    ends = Date.new(2018,1,31)
    mondays = [starts, starts + 7, starts + 14, starts + 21, starts + 28]

    resource.starts_on = starts
    resource.ends_on = ends
    resource.days_of_week = [1]

    expect(resource.all_occurrences).to eq(mondays)
  end

  it "returns correct occurrences when meeting multiple days in a week" do
    multiple_days = Resource.new
    starts = Date.new(2018,1,1)
    ends = Date.new(2018,1,31)
    mon_and_wed = [starts, starts + 2, starts + 7, starts + 9, starts + 14, starts + 16, starts + 21, starts + 23, starts + 28, starts + 30 ]

    multiple_days.starts_on = starts
    multiple_days.ends_on = ends
    multiple_days.days_of_week = [1,3]
    
    expect(multiple_days.all_occurrences).to eq(mon_and_wed)

  end

  it "returns the correct occurrences while spanning a leap day" do
    leap_resource = Resource.new
    leap_resource.starts_on = Date.new(2020,2,1)
    leap_resource.ends_on = Date.new(2020, 3,7)
    leap_resource.days_of_week = [6]
    saturdays = [leap_resource.starts_on, leap_resource.starts_on + 7, leap_resource.starts_on + 14, leap_resource.starts_on + 21, leap_resource.starts_on + 28, leap_resource.starts_on + 35]

    expect(leap_resource.all_occurrences).to eq(saturdays)
  end

  it "returns the correct occurrences while spanning a new year" do
    year_resource = Resource.new
    year_resource.starts_on = Date.new(2017,12,28)
    year_resource.ends_on = Date.new(2018,1,8)
    year_resource.days_of_week = [4]
    thursdays = [year_resource.starts_on, year_resource.starts_on + 7]

    expect(year_resource.all_occurrences).to eq(thursdays)
  end
end
