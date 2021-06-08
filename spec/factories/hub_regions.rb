FactoryBot.define do
  factory :hub_region do
    name { Faker::Address.state }
    sequence(:order)
  end
end
