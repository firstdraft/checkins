# frozen_string_literal: true

json.extract! meeting, :id, :date, :start_time, :end_time, :resource_id, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
