FactoryBot.define do
  factory :contact_phone do
    phone { Faker::Number.number(digits: 10) }
    association :clients, factory: :client
  end
end
