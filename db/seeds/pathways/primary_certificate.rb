puts 'Creating Pathways for Primary Certificate'

programme = Programme.primary_certificate

pathway = programme.pathways.find_or_initialize_by(slug: 'developing-in-the-classroom')
pathway.update(
  title: 'Developing in the classroom',
  slug: 'developing-in-the-classroom',
  range: 0..0,
  pdf_link: 'TBC',
  programme_id: programme.id,
  order: 1
)

# face to face / remote / online

activity = Activity.find_by(stem_course_template_no: '6bc40e34-4c86-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1)
end

# activity = Activity.find_by(stem_course_template_no: '6bc40e34-4c86-ea11-a811-000d3a86d545') needs sorting
# if activity && !pathway.pathway_activities.include?(activity)
#   pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2)
# end

# activity = Activity.find_by(stem_course_template_no: '6bc40e34-4c86-ea11-a811-000d3a86d545') needs sorting
# if activity && !pathway.pathway_activities.include?(activity)
#   pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3)
# end

activity = Activity.find_by(stem_course_template_no: '88975226-811c-ec11-b6e7-0022481a8033')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4)
end

activity = Activity.find_by(stem_course_template_no: '34ff2768-a7fc-ea11-a813-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 5)
end

activity = Activity.find_by(future_learn_course_uuid: '147b3adf-9f26-4ffa-a95f-6c1720ca4d27')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 6)
end

# activity = Activity.find_by(future_learn_course_uuid: '34ff2768-a7fc-ea11-a813-000d3a86d545') needs confirming
# if activity && !pathway.pathway_activities.include?(activity)
#   pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 7)
# end

activity = Activity.find_by(future_learn_course_uuid: 'b2445d09-f3b3-45da-b4ec-6d33bb6cb89b')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 8)
end

activity = Activity.find_by(future_learn_course_uuid: 'b19646a7-d78b-4a92-ad36-d4b3a11a3df1')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 9)
end


# develop your teaching practice

activity = Activity.find_by(slug: 'review-a-resource-on-cas')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1)
end

activity = Activity.find_by(slug: 'host-or-attend-a-barefoot-workshop')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2)
end

activity = Activity.find_by(slug: 'raise-aspirations-with-a-stem-ambassador-visit')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3)
end

activity = Activity.find_by(slug: 'attend-a-cas-community-meeting')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4)
end

# develop computing in your community

activity = Activity.find_by(slug: 'run-an-after-school-code-club')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1)
end

activity = Activity.find_by(slug: 'providing-additional-support')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2)
end

pathway = programme.pathways.find_or_initialize_by(slug: 'specialising-or-leading')
pathway.update(
  title: 'Specialising or leading',
  slug: 'specialising-or-leading',
  range: 0..0,
  pdf_link: 'TBC',
  programme_id: programme.id,
  order: 1
)

# activity = Activity.find_by(stem_course_template_no: '6bc40e34-4c86-ea11-a811-000d3a86d545')
# if activity && !pathway.pathway_activities.include?(activity)
#   pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1)
# end

activity = Activity.find_by(stem_course_template_no: '11f58c3f-3341-eb11-a813-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2)
end

activity = Activity.find_by(stem_course_template_no: '34ff2768-a7fc-ea11-a813-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3)
end

activity = Activity.find_by(future_learn_course_uuid: '26e9cd23-2d71-4964-9af3-751aa3fdc8e5')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4)
end

activity = Activity.find_by(future_learn_course_uuid: '440d652-4128-4995-9ef7-662a0bc505ed')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 5)
end

activity = Activity.find_by(future_learn_course_uuid: '7e5ae100-f4fc-425b-a53b-c81cb6eb4abc')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 6)
end

activity = Activity.find_by(stem_course_template_no: 'ee8a70b8-1607-ec11-b6e6-000d3a86d86c')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 7)
end

# develop your teaching practice

activity = Activity.find_by(slug: 'review-a-resource-on-cas')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1)
end

activity = Activity.find_by(slug: 'host-or-attend-a-barefoot-workshop')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2)
end

activity = Activity.find_by(slug: 'raise-aspirations-with-a-stem-ambassador-visit')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3)
end

# develop computing in your community

activity = Activity.find_by(slug: 'run-an-after-school-code-club')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1)
end

activity = Activity.find_by(slug: 'lead-a-session-at-a-regional-or-national-conference')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2)
end

activity = Activity.find_by(slug: 'lead-a-cas-community-of-practice')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3)
end

activity = Activity.find_by(slug: 'providing-additional-support')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4)
end
