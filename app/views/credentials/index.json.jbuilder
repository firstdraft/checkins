# frozen_string_literal: true

json.array! @credentials, partial: "credentials/credential", as: :credential
