FactoryBot.define do
  factory :user_programme_enrolment do
    user
    programme

    factory :completed_enrolment do
      after(:create) do |enrolment|
        enrolment.transition_to :complete
      end
    end
  end
end
