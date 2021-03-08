task populate_remote_delivered_cpd_for_activities: :environment do
  templates = Achiever::Course::Template.all

  templates.each do |template|
    activity = Activity.find_by(stem_course_template_no: template.course_template_no)
    next if activity.nil?

    activity.update(remote_delivered_cpd: template.remote_delivered_cpd)
  end
end
