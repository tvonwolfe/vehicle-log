# frozen_string_literal: true

json.extract! vehicle, :id, :created_at, :updated_at
json.url vehicle_url(vehicle, format: :json)
