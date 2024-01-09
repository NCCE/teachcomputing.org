namespace :achiever do
  task get_course_info: :environment do
    methods = [Achiever::Course::Template::RESOURCE_PATH,
      Achiever::Course::Occurrence::FACE_TO_FACE_RESOURCE_PATH,
      Achiever::Course::Occurrence::ONLINE_RESOURCE_PATH,
      Achiever::Course::AgeGroup::RESOURCE_PATH,
      Achiever::Course::Subject::RESOURCE_PATH]
    methods.each do |method_id|
      puts Rails.cache.delete(method_id)
    end

    beginning_time = Time.zone.now

    courses = Achiever::Course::Template.all
    face_2_face_courses = Achiever::Course::Occurrence.face_to_face
    online_courses = Achiever::Course::Occurrence.online
    Achiever::Course::Subject.all
    Achiever::Course::AgeGroup.all

    end_time = Time.zone.now
    puts "Achiever currently has #{courses.count} courses with #{face_2_face_courses.count} F2F & #{online_courses.count} online occurrences"
    puts "Time: #{end_time - beginning_time} s."
  end
end
