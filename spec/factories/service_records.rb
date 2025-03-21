FactoryBot.define do
  factory :service_record do
    log_entry
    title { Faker::Book.title }
    service_type { :maintenance }
    description { Faker::Lorem.paragraph }
    cost { 25 } # $25
  end
end
