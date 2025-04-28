FactoryBot.define do
  factory :vehicle do
    user
    vin { Faker::Vehicle.vin }
    model_year { Faker::Date.between(from: '1925-01-01'.to_date, to: Date.current).year }
    manufacturer { Faker::Vehicle.manufacturer }
    model { Faker::Vehicle.model }
    license_plate_number { Faker::Vehicle.license_plate }
  end
end
