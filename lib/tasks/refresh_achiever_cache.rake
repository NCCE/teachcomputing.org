require(Rails.root.join('app', 'lib', 'achiever.rb'))

namespace :achiever do
  task get_course_info: :environment do
    workflow_ids = %w[
      ACHIEVER_APPROVED_COURSE_TEMPLATES_WORKFLOW_ID
      ACHIEVER_FACE_TO_FACE_FUTURE_COURSES_WORKFLOW_ID
      ACHIEVER_ONLINE_FUTURE_COURSES_WORKFLOW_ID
      ACHIEVER_COURSES_FOR_DELEGATE_WORKFLOW_ID
      ACHIEVER_COURSES_FOR_DELEGATE_WORKFLOW_ID
    ]
    workflow_ids.each do |workflow_id|
      key = "#{ENV[workflow_id]}-#{Date.today}"
      puts Rails.cache.delete(key)
    end

    beginning_time = Time.zone.now
    achiever = Achiever.new
    courses = achiever.approved_course_templates
    face_2_face_courses = achiever.future_face_to_face_courses
    online_courses = achiever.future_online_courses

    courses.each do |course|
      workflow_ids = %w[
        ACHIEVER_COURSE_TEMPLATE_SUBJECT_DETAILS_WORKFLOW_ID
        ACHIEVER_COURSE_TEMPLATE_AGE_RANGE_WORKFLOW_ID
      ]
      workflow_ids.each do |workflow_id|
        key = "#{ENV[workflow_id]}-#{course.course_template_no}-#{Date.today}"
        puts Rails.cache.delete(key)
      end
      achiever.course_template_subject_details(course)
      achiever.course_template_age_range(course)
    end

    end_time = Time.zone.now
    puts "Achiever currently has #{courses.count} courses with #{face_2_face_courses.count} F2F & #{online_courses.count} online occurrences"
    puts "Time: #{(end_time - beginning_time)} s."
  end
end
