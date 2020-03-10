FactoryBot.define do
  factory :questionnaire_response do
    questionnaire
    user
    programme
    current_question { 0 }
    answers { {} }
  end
end
