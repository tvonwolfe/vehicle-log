FactoryBot.define do
  factory :log_entry do
    vehicle
    performed_on { Date.yesterday }
    mileage { Faker::Number.number }

    trait :with_service_record do
      after(:build) do |log_entry|
        log_entry.service_record = build(:service_record, log_entry:)
      end
    end
  end
end
