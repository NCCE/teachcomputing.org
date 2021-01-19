FactoryBot.define do
  factory :pathway_activity do
    pathway
    activity
    supplemental { false }
    order { 1 }
  end
end
