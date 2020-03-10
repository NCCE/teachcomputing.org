FactoryBot.define do
  factory :questionnaire do
    programme
    title { 'Questionnaire Title' }
    slug { 'test-questionnaire' }
    description { 'A long rambling description about how good questionnaires are...' }
  end
end
