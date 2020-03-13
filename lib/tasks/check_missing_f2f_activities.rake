task check_missing_f2f_activities: :environment do

  f2f_courses = Achiever::Course::Template.all.select { |c| c.online_cpd == false }

  f2f_activities = Activity.face_to_face

  puts "Checking #{f2f_activities.count} activities with #{f2f_courses.count} f2f courses"

  missing_activities = []
  f2f_courses.each do |c|
    activity = Activity.find_by(title: c.title)

    if activity
      f2f_activities = f2f_activities.reject { |a| a.id == activity.id }
    else
      missing_activities << { title: c.title, stem_course_template_no: c.course_template_no }
    end
  end

  puts "#{missing_activities.count} F2F activities could not be found\n"
  puts missing_activities

  puts "F2F activities in the DB without a matching course (may duplicate some missing activities)\n"
  puts f2f_activities.pluck(:slug)
end

