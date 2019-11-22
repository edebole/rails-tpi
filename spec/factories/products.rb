FactoryBot.define do
  factory :product do
    unique_code { "MyString" }
    description { "MyString" }
    detail { "MyText" }
    unit_price { "9.99" }
    items { nil }
  end
end
