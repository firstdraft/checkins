# frozen_string_literal: true

json.extract! resource, :id, :context_id, :meeting_schedule_hash, :created_at, :updated_at
json.url resource_url(resource, format: :json)
