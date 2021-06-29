FactoryBot.define do
  factory :hub do
    name {  Faker::Company.name}
    hub_region
    subdeliverer_id { SecureRandom.uuid }
    address { Faker::Address.street_address }
    postcode { Faker::Address.postcode }
    email { Faker::Internet.email }
    phone { '01141234567' }
    website { 'http://example.com' }
    twitter { '@hubtwitter' }
    facebook { '@hubfacebook' }
    satellite { false }
    satellite_info { Faker::Lorem.sentences(number: 1) }
  end
end
