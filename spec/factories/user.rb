FactoryBot.define do
  factory :user do
    first_name { 'Jane' }
    last_name { 'Doe' }
    sequence(:email, 1000) { |n| "user#{n}@example.com" }
    sequence(:stem_achiever_contact_no, 1000) { |n| "achiever-#{n}" }
    sequence(:stem_user_id, 1000) { |n| "id-#{n}" }
    stem_credentials_access_token { 'CD355FC7DCCD9C7BB7E2C29F4BE3F' }
    stem_credentials_refresh_token { '7BF7E7C2EB515FBC5BA4D2F7B3E8B' }
    stem_credentials_expires_at { Time.now }
    last_sign_in_at { Time.now }
  end
end
