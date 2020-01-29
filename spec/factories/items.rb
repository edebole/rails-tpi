FactoryBot.define do
  factory :item do
    state { "disponible" }
    association :products, factory: :product
  end
end
