require(Rails.root.join('app', 'lib', 'achiever.rb'))

namespace :achiever do
  task get_course_info: :environment do
    beginning_time = Time.zone.now
    achiever = Achiever.new
    courses = achiever.approved_course_templates
    face_2_face_courses = achiever.future_face_to_face_courses
    online_courses = achiever.future_online_courses

    courses.each do |course|
      achiever.course_template_subject_details(course)
      achiever.course_template_age_range(course)
    end

    end_time = Time.zone.now
    puts "Achiever currently has #{courses.count} courses with #{face_2_face_courses.count} F2F & #{online_courses.count} online occurrences"
    puts "Time: #{(end_time - beginning_time)} s."
  end
end
