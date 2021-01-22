FactoryBot.define do
  factory :pathway_activity do
    pathway
    activity
    order { 1 }
  end
end
