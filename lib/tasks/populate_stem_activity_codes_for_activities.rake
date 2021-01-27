task populate_stem_activity_codes_for_activities: :environment do
  activities = Activity.where(provider: 'stem-learning').or(Activity.where(provider: 'future-learn'))
  templates = Achiever::Course::Template.all

  activities.each do |activity|
    template = templates.select { |tmp| tmp.course_template_no == activity.stem_course_template_no }
    next if template.empty?

    activity.update_attributes(stem_activity_code: template.first.activity_code)
  end
end
