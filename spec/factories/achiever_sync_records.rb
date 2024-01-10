FactoryBot.define do
  factory :achiever_sync_record do
    user_programme_enrolment
    state { "enrolled" }
  end
end
