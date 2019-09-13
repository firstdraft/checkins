FactoryBot.define do
  factory :resource do
    meeting_schedule_hash   { "default-meeting-schedule-hash" }
    lis_outcome_service_url { "www.default-outcome-service-url.com" }
    lti_resource_link_id    { "default-resource-link-id" }
    context                         
    starts_on               { Date.today}
    ends_on                 { 11.weeks.from_now}
    sunday                  { false }
    monday                  { false }
    tuesday                 { false }
    wednesday               { false }
    thursday                { false }
    friday                  { false }
    saturday                { false }   
  end
end
