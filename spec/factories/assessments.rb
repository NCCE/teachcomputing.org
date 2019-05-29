FactoryBot.define do
  factory :assessment do
    link { 'https://link.com/quiz101' }
    sequence(:class_marker_test_id, 100) { |n| n }
    activity
    programme
  end
end
