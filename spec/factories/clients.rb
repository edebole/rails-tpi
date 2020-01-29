FactoryBot.define do
  factory :client do
    cuil_cuit { '20393466546' }
    email { Faker::Internet.email }
    name { Faker::Name.name }
    vat_condition
  end
end
