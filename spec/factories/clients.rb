FactoryBot.define do
  factory :client do
    cuil_cuit { "MyString" }
    email { "MyString" }
    name { "MyString" }
    vat_condition { nil }
  end
end
