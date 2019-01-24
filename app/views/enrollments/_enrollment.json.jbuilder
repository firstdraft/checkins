# frozen_string_literal: true

json.extract! enrollment, :id, :resource_id, :user_id, :created_at, :updated_at
json.url enrollment_url(enrollment, format: :json)
