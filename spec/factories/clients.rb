FactoryBot.define do
  factory :client do
    cuil_cuit { Faker::Number.number(digits: 11) }
    email { Faker::Internet.email }
    name { Faker::Name.name }
    vat_condition {FactoryBot.create(:vat_condition)}
  end
end
