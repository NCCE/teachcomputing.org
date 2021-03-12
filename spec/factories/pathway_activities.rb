FactoryBot.define do
  factory :pathway_activity do
    pathway
    activity
    sequence(:order) { |n| n }
  end
end
