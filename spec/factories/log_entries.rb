FactoryBot.define do
  factory :log_entry do
    vehicle
    performed_on { Date.yesterday }
    mileage { Faker::Number.number }
  end
end
