task downcase_activity_uuids: :environment do
  activites = Activity.all

  activites.each do |activity|
    activity.update(
      stem_course_template_no: activity.stem_course_template_no&.downcase,
      future_learn_course_uuid: activity.future_learn_course_uuid&.downcase
    )
  end
end
