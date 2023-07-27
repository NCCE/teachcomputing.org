puts 'Creating Pathways for Primary Certificate'

programme = Programme.primary_certificate

pathway = programme.pathways.find_or_initialize_by(slug: 'developing-in-the-classroom')
pathway.update(
  title: 'Developing in the classroom',
  slug: 'developing-in-the-classroom',
  description: 'Are you a classroom teacher who wants to strengthen your knowledge of primary computing and develop your teaching of the subject? This pathway will help you to develop the understanding and skills to teach computing effectively.',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/primary-pathways/Developing-in-the-Classroom.pdf',
  programme_id: programme.id,
  order: 1
)

# face to face / remote

# CP454/introduction-to-primary-computing-remote
activity = Activity.find_by(stem_course_template_no: 'bb7a0f31-5086-ea11-a811-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

# online

# CO041/teaching-programming-to-5-to-11-year-olds
activity = Activity.find_by(stem_course_template_no: '563c4bde-a6b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

# CO700/creating-an-inclusive-classroom-approaches-to-supporting-learners-with-send-in-computing
activity = Activity.find_by(stem_course_template_no: 'ded270cb-a4b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

# CO232/introduction-to-programming-with-scratch
activity = Activity.find_by(stem_course_template_no: '06e59bb7-a1b6-ed11-b597-0022481b59ce')
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

########################################################################################################################

pathway = programme.pathways.find_or_initialize_by(slug: 'specialising-or-leading')
pathway.update(
  title: 'Specialising or leading',
  slug: 'specialising-or-leading',
  description: 'Are you taking on a subject leadership role or looking to specialise in computing? This pathway will support you to build the confidence to lead computing effectively in your primary school.',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/primary-pathways/Specialising-or-leading.pdf',
  programme_id: programme.id,
  order: 1
)

# CP008/leading-primary-computing-face-to-face
activity = Activity.find_by(stem_course_template_no: 'e3c14378-3015-eb11-a813-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

# CP456/leading-primary-computing-remote
activity = Activity.find_by(stem_course_template_no: '3bff03fd-256d-eb11-a812-000d3a872640')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

# CP005/outstanding-primary-computing-for-all-face-to-face
activity = Activity.find_by(stem_course_template_no: '34ff2768-a7fc-ea11-a813-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

# CP255/implementing-the-teach-computing-curriculum-in-your-school
activity = Activity.find_by(stem_course_template_no: '726ece56-27b0-ec11-983f-002248006a24')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)

# CO700/creating-an-inclusive-classroom-approaches-to-supporting-learners-with-send-in-computing
activity = Activity.find_by(stem_course_template_no: 'ded270cb-a4b6-ed11-b597-0022481b59ce')
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
