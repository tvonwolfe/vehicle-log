FactoryBot.define do
  factory :user do
    email_address { Faker::Internet.email }
    password { Faker::Alphanumeric.alphanumeric(number: 12) }
  end
end
