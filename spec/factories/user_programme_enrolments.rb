FactoryBot.define do
  factory :user_programme_enrolment do
    user
    programme

    before(:create) do |enrolment|
      if enrolment.programme.pathways? && enrolment.pathway.nil?
        enrolment.pathway = enrolment.programme.pathways.first
      end
    end

    factory :completed_enrolment do
      after(:create) do |enrolment|
        enrolment.transition_to :complete
      end
    end
  end
end
