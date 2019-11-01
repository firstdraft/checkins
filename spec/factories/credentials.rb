FactoryBot.define do
  factory :credential do
    consumer_key { "key" }
    consumer_secret { "secret" }
    enabled { true }
    administrator
  end
end
