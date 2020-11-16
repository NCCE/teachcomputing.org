
task remove_incorrect_course_programme_activities: :environment do
  activities = ['258c93cc-69e2-46f6-bf39-fbce27cb8fc2', '1dcba944-6ae9-4b68-af69-56df49495bd7']
  programme = Programme.cs_accelerator

  activities.each do |activity_stem_id|
    activity = Activity.find_by(stem_course_template_no: activity_stem_id)
    programme_activity = ProgrammeActivity.find_by(programme_id: programme.id, activity_id: activity.id)
    programme_activity.delete
  end
end
