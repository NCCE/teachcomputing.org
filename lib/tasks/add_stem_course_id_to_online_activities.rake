task add_stem_course_template_no_to_online_activities: :environment do

  online_courses = Achiever::Course::Template.all.select { |c| c.online_cpd == true }

  online_activities = Activity.online

  puts "Updating #{online_activities.count} activities with #{online_courses.count} online courses"

  missing_activities = []
  updated = 0
  online_courses.each do |c|
    activity = Activity.find_by(title: c.title)

    if activity
      activity.update(stem_course_template_no: c.course_template_no)
      online_activities = online_activities.reject { |a| a.id == activity.id }
      updated += 1
    else
      missing_activities << { title: c.title, stem_course_template_no: c.course_template_no }
    end
  end

  puts "Updated #{updated} activities #{missing_activities.count} could not be found\n"
  puts missing_activities

  puts "Online activities in the DB without a matching course (may duplicate some missing activities)\n"
  puts online_activities.pluck(:slug)
end

