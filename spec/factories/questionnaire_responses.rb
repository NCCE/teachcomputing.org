FactoryBot.define do
  factory :questionnaire_response do
    questionnaire
    user
    answers { {} }

    trait :primary_enrolment_questionnaire_response do
      association :questionnaire, :primary_enrolment_questionnaire
    end

    trait :cs_accelerator_enrolment_questionnaire_response do
      association :questionnaire, :cs_accelerator_enrolment_questionnaire
    end

    trait :score_of_15 do
      answers { {"1" => 0, "2" => 5, "3" => 5, "4" => 5} }
    end

    trait :score_of_1 do
      answers { {"1" => 1} }
    end

    factory :primary_enrolment_score_15, traits: %i[primary_enrolment_questionnaire_response score_of_15]
    factory :cs_accelerator_enrolment_score_15, traits: %i[cs_accelerator_enrolment_questionnaire_response score_of_15]
    factory :cs_accelerator_enrolment_score_1, traits: %i[cs_accelerator_enrolment_questionnaire_response score_of_1]

    factory :primary_enrolment_unanswered, traits: %i[primary_enrolment_questionnaire_response]
    factory :cs_accelerator_enrolment_unanswered, traits: %i[cs_accelerator_enrolment_questionnaire_response]
  end
end
