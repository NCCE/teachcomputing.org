FactoryBot.define do
  factory :questionnaire do
    programme
    title { "Questionnaire Title" }
    slug { "test-questionnaire" }
    description { "A long rambling description about how good questionnaires are..." }

    trait :primary_enrolment_questionnaire do
      slug { "primary-certificate-enrolment-questionnaire" }
    end

    trait :cs_accelerator_enrolment_questionnaire do
      slug { "subject-knowledge-enrolment-questionnaire" }
    end

    factory :csa_enrolment_questionnaire do
      slug { "subject-knowledge-enrolment-questionnaire" }
    end
  end
end
