FactoryBot.define do
  factory :achiever_course_occurrence, class: "Achiever::Course::Occurrence" do
    sequence(:activity_code) { |n| "A0#{n}" }
    activity_title { "Activity title" }
    address_venue_name { Faker::Address.street_name }
    address_venue_code { Faker::Number.leading_zero_number(digits: 5) }
    address_town { Faker::Address.city }
    address_postcode { Faker::Address.postcode }
    address_line_one { Faker::Address.street_address }
    age_groups { "157430001;157430011" }
    booking_url { "" }
    course_template_no { Faker::Alphanumeric.alphanumeric(number: 10) }
    course_occurrence_no { Faker::Alphanumeric.alphanumeric(number: 10) }
    end_date { "15/02/2099 00:00:00" }
    hub_id { "" }
    online_cpd { false }
    region { "" }
    remote_delivered_cpd { false }
    subject { Faker::Number.number(digits: 9).to_s }

    start_date { "15/01/2099 00:00:00" }
  end
end
