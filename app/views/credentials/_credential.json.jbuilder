json.extract! credential, :id, :consumer_key, :consumer_secret, :administrator_id, :created_at, :updated_at
json.url credential_url(credential, format: :json)
