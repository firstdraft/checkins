# frozen_string_literal: true

json.extract! context, :id, :title, :credential_id, :created_at, :updated_at
json.url context_url(context, format: :json)
