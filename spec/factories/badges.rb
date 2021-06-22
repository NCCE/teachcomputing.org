FactoryBot.define do
  factory :badge do
    credly_badge_template_id { '00cd7d3b-baca-442b-bce5-f20666ed591b' }
    academic_year { '2019-20' }
    active { false }
    programme

    trait :active do
      academic_year { '2020-21' }
      active { true }
    end
  end
end
