FactoryBot.define do
  factory :programme_activity do
    programme
    activity
    legacy { false }
  end
end
