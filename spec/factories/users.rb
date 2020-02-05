FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 5..8, separators: %w(_ -)) }
    password { "password" }
  end
end
