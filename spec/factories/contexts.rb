#  id               :bigint(8)        not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  title            :string
#  lti_context_id   :string
#  credential_id    :integer
#  allowed_absences :integer          default(0)
#
FactoryBot.define do
  factory :context do
    title { "Context Title" }
    lti_context_id { "some-lti-id" }
    allowed_absences { 2 }
    credential
  end
end
