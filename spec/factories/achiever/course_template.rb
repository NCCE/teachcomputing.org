FactoryBot.define do
  factory :achiever_course_template, class: 'Achiever::Course::Template' do
    sequence(:activity_code, 100) { |n| "CP#{n}" }
    age_groups { %w[000000000] }
    booking_url { '' }
    course_template_no { SecureRandom.uuid }
    duration_value { '1' }
    meta_description { 'Course meta description' }
    online_cpd { false }
    outcomes { '' }
    programmes { ['Subject Knowledge'] }
    remote_delivered_cpd { false }
    subjects { %w[000000000] }
    summary { '' }
    title { 'Achiever course template title' }
    workstream { 'CS Accelerator' }
    occurrences { [] }
  end
end
