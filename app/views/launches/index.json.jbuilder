# frozen_string_literal: true

json.array! @launches, partial: 'launches/launch', as: :launch
