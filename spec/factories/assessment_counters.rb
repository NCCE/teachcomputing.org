FactoryBot.define do
  factory :assessment_counter do
    assessment
    counter { 0 }
  end
end
