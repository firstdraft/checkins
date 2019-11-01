FactoryBot.define do
  factory :meeting do
    sequence(:start_time) { |n| Time.current.at_noon.in_time_zone("Central Time (US & Canada)") +     n.days }
    sequence(:end_time)   { |n| Time.current.at_noon.in_time_zone("Central Time (US & Canada)") +     3.hours + n.days}
    resource  
  end
end
