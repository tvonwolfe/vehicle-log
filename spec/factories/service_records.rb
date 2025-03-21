FactoryBot.define do
  factory :service_record do
    log_entry
    service_type { :maintenance }
    description { Faker::Lorem.paragraph }
  end
end
