FactoryBot.define do
  factory :questionnaire_response do
    questionnaire
    user
    programme
    # current_question { 1 }
    answers { {} }

    trait :primary_enrolment_questionnaire_response do
      association :questionnaire, :primary_enrolment_questionnaire
    end

    trait :score_of_15 do
      answers { { '1' => 0, '2' => 5, '3' => 5, '4' => 5 } }
    end

    factory :primary_enrolment_score_15, traits: [:primary_enrolment_questionnaire_response, :score_of_15]

    factory :primary_enrolment_unanswered, traits: [:primary_enrolment_questionnaire_response]
  end
end
