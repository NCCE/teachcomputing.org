FactoryBot.define do
  factory :questionnaire do
    programme
    title { 'Questionnaire Title' }
    slug { 'test-questionnaire' }
    description { 'A long rambling description about how good questionnaires are...' }

    trait :primary_enrolment_questionnaire do
      slug { 'primary-certificate-enrolment-questionnaire' }
    end
  end


end
