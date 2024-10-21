FactoryBot.define do
  factory :course_delegate, class: "Achiever::Course::Delegate" do
    course_occurence_no { Faker::Number.number(digits: 8) }
    course_template_no { Faker::Number.number(digits: 8) }
    is_fully_attended { "false" }
    online_cpd { false }
    progress { "157420003" }
    address_venue_name { Faker::Company.name }
    address_venue_code { Faker::Alphanumeric.alphanumeric(number: 6) }
    address_town { Faker::Address.city }
    address_postcode { Faker::Address.postcode }
    address_line_one { Faker::Address.street_address }
    start_date { Faker::Date.backward(days: 30) }
    end_date { Faker::Date.forward(days: 30) }

    initialize_with do
      new(OpenStruct.new(
        attributes.merge(
          "Delegate.Is_Fully_Attended" => is_fully_attended
        )
      ))
    end
  end
end
