FactoryBot.define do
  factory :badge do
    credly_badge_template_id { '00cd7d3b-baca-442b-bce5-f20666ed591b' }
    active { false }
    programme

    trait :active do
      active { true }
    end
  end
end
