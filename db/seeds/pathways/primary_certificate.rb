puts 'Creating Pathways for Primary Certificate'

programme = Programme.primary_certificate

pathway = programme.pathways.find_or_initialize_by(slug: 'developing-in-the-classroom')
pathway.update(
  title: 'Developing in the classroom',
  slug: 'developing-in-the-classroom',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/primary-pathways/Developing-in-the-Classroom.pdf',
  programme_id: programme.id,
  order: 1
)

# face to face / remote / online

activity = Activity.find_by(stem_course_template_no: '68f5b6c5-556d-4b66-8159-7cd6019da6f3')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(stem_course_template_no: '488bed9b-515b-4295-a488-62b5bb6bf852')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(stem_course_template_no: '16aeecbd-d202-4f42-bad3-f86c8f671547')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(stem_course_template_no: '88975226-811c-ec11-b6e7-0022481a8033')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(stem_course_template_no: '34ff2768-a7fc-ea11-a813-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(future_learn_course_uuid: '147b3adf-9f26-4ffa-a95f-6c1720ca4d27')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(future_learn_course_uuid: '7f88c178-9538-4970-b438-ab80e6125d5e')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(future_learn_course_uuid: 'b2445d09-f3b3-45da-b4ec-6d33bb6cb89b')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(future_learn_course_uuid: 'b19646a7-d78b-4a92-ad36-d4b3a11a3df1')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

# develop your teaching practice

activity = Activity.find_by(slug: 'review-a-resource-on-cas')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(slug: 'host-or-attend-a-barefoot-workshop')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(slug: 'raise-aspirations-with-a-stem-ambassador-visit')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(slug: 'attend-a-cas-community-meeting')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

# develop computing in your community

activity = Activity.find_by(slug: 'run-an-after-school-code-club')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(slug: 'providing-additional-support')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

pathway = programme.pathways.find_or_initialize_by(slug: 'specialising-or-leading')
pathway.update(
  title: 'Specialising or leading',
  slug: 'specialising-or-leading',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/primary-pathways/Specialising-or-leading.pdf',
  programme_id: programme.id,
  order: 1
)

activity = Activity.find_by(stem_course_template_no: 'e3c14378-3015-eb11-a813-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(stem_course_template_no: '11f58c3f-3341-eb11-a813-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(stem_course_template_no: '34ff2768-a7fc-ea11-a813-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(future_learn_course_uuid: '26e9cd23-2d71-4964-9af3-751aa3fdc8e5')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(future_learn_course_uuid: '440d652-4128-4995-9ef7-662a0bc505ed')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(future_learn_course_uuid: '7e5ae100-f4fc-425b-a53b-c81cb6eb4abc')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(stem_course_template_no: 'ee8a70b8-1607-ec11-b6e6-000d3a86d86c')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

# develop your teaching practice

activity = Activity.find_by(slug: 'review-a-resource-on-cas')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(slug: 'host-or-attend-a-barefoot-workshop')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(slug: 'raise-aspirations-with-a-stem-ambassador-visit')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

# develop computing in your community

activity = Activity.find_by(slug: 'run-an-after-school-code-club')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(slug: 'lead-a-session-at-a-regional-or-national-conference')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(slug: 'lead-a-cas-community-of-practice')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

activity = Activity.find_by(slug: 'providing-additional-support')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)
