FactoryBot.define do
  factory :invitation do
    code { Faker::Alphanumeric.alphanumeric(number: 16) }

    trait :with_user do
      user
    end
  end
end
