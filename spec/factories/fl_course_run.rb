FactoryBot.define do
  factory :fl_course_run, class: Hash do
    transient do
      run_uuid { SecureRandom.uuid }
      course_uuid { SecureRandom.uuid }
    end

    uuid { run_uuid }
    href { "https://testapi.com/course_runs/#{run_uuid}" }
    title { "Course Run #{run_uuid}" }
    full_code { nil }
    code { nil }
    start_time { (DateTime.now - 1.day).to_s }
    weeks_count { 4 }
    course do
      {
        uuid: course_uuid,
        href: "https://testapi.com/courses/#{course_uuid}"
      }
    end

    initialize_with { attributes }
  end
end
