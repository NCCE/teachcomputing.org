FactoryBot.define do
  factory :badge do
    credly_badge_template_id { SecureRandom.uuid }
    academic_year { "2019-20" }
    active { false }
    programme

    trait :active do
      academic_year { "2020-21" }
      active { true }
    end
  end
end
