FactoryBot.define do
  factory :hub do
    name { Faker::Company.name }
    hub_region
    subdeliverer_id { SecureRandom.uuid }
    address { Faker::Address.street_address }
    postcode { Faker::Address.postcode }
    email { Faker::Internet.email }
    phone { '01141234567' }
    website { 'http://example.com' }
    twitter { '@hubtwitter' }
    facebook { 'hubfacebook' }
    linkedin { 'https://linkedin.com' }
    satellite { false }
    satellite_info { Faker::Lorem.sentence(word_count: 16) }
  end
end
