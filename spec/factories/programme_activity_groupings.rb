FactoryBot.define do
  factory :programme_activity_grouping do
    title { 'A group name' }
    required_for_completion { 1 }
    sort_key { 1 }
    programme
  end
end
