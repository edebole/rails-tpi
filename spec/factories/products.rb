FactoryBot.define do
  factory :product do
    unique_code { Faker::Alphanumeric.alphanumeric(number: 9, min_alpha: 3, min_numeric: 6) }
    description { Faker::Commerce.product_name }
    detail { Faker::Lorem.paragraph }
    unit_price { Faker::Commerce.price }
  end
end
