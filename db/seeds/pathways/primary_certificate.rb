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
  order: 1,
  legacy: true
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
  order: 1,
  legacy: true
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

programme.pathways.find_or_initialize_by(slug: 'specialising-or-leading-2').tap do |pathway|
  pathway.title = 'Specialising or leading'
  pathway.slug = 'specialising-or-leading-2'
  pathway.description = 'Are you taking on a subject leadership role or looking to specialise in computing? This pathway will support you to build the confidence and expertise to lead computing effectively in your primary school.'
  pathway.range = 0..0
  pathway.pdf_link = 'https://static.teachcomputing.org/primary-pathways/Developing-in-the-Classroom.pdf'
  pathway.programme_id = programme.id
  pathway.order = 4

  pathway.enrol_copy = [
    'Enrol with the click of the button',
    'Complete the required professional development, engagement, and community activities to receive your qualification'
  ]

  pathway.save

  # CPDs
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP008')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP456')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP007')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP005')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP225')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP003')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CO040')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CO042')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CO700')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP486')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP469')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP441')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP252')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP292')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP461')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP457')

  # Develop your teaching practice
  maybe_attach_activity_to_pathway(pathway, slug: 'raise-aspirations-with-a-stem-ambassador-visit')
  maybe_attach_activity_to_pathway(pathway, slug: 'participate-fully-in-an-ncce-curriculum-enrichment-oppertunity')
  maybe_attach_activity_to_pathway(pathway, slug: 'implement-your-professional-development-in-the-classroom-and-evaluate-via-the-impact-toolkit')
  maybe_attach_activity_to_pathway(pathway, slug: 'download-and-use-the-ncce-teaching-and-assessment-resources-in-your-classroom')

  # Develop computing in your community
  maybe_attach_activity_to_pathway(pathway, slug: 'gain-accreditation-as-a-professional-development-leader')
  maybe_attach_activity_to_pathway(pathway, slug: 'support-other-teachers-and-earn-a-stem-community-participation-badge')
  maybe_attach_activity_to_pathway(pathway, slug: 'undertake-the-initial-assessment-of-your-school-using-computing-quality-framework')
  maybe_attach_activity_to_pathway(pathway, slug: 'work-with-your-local-computing-hub-to-develop-a-school-level-action-plan-for-professional-development')
  maybe_attach_activity_to_pathway(pathway, slug: 'lead-your-school-into-a-computing-cluster-and-develop-an-action-plan-with-a-cluster-advisor')
  maybe_attach_activity_to_pathway(pathway, slug: 'join-and-present-at-your-local-computing-at-school-community')
end

programme.pathways.find_or_initialize_by(slug: 'developing-in-the-classroom-2').tap do |pathway|
  pathway.title = 'Developing in the classroom'
  pathway.slug = 'developing-in-the-classroom-2'
  pathway.description = 'Are you taking on a subject leadership role or looking to specialise in computing? This pathway will support you to build the confidence and expertise to lead computing effectively in your primary school.'
  pathway.range = 0..0
  pathway.pdf_link = 'https://static.teachcomputing.org/primary-pathways/Developing-in-the-Classroom.pdf'
  pathway.programme_id = programme.id
  pathway.order = 3

  pathway.enrol_copy = [
    'Enrol with the click of the button',
    'Complete the required professional development, engagement, and community activities to receive your qualification'
  ]

  pathway.save

  # CPDs
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP454')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP455')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CO232')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CO700')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CO041')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CO042')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP462')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP466')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP459')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP465')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP460')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP467')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP252')
  maybe_attach_activity_to_pathway(pathway, stem_activity_code: 'CP292')

  # Develop your teaching practice
  maybe_attach_activity_to_pathway(pathway, slug: 'raise-aspirations-with-a-stem-ambassador-visit')
  maybe_attach_activity_to_pathway(pathway, slug: 'participate-fully-in-an-ncce-curriculum-enrichment-oppertunity')
  maybe_attach_activity_to_pathway(pathway, slug: 'implement-your-professional-development-in-the-classroom-and-evaluate-via-the-impact-toolkit')
  maybe_attach_activity_to_pathway(pathway, slug: 'download-and-use-the-ncce-teaching-and-assessment-resources-in-your-classroom')

  # Develop computing in your community
  maybe_attach_activity_to_pathway(pathway, slug: 'share-tips-on-using-an-ncce-resource-in-your-classroom-with-colleagues-on-stem-community')
  maybe_attach_activity_to_pathway(pathway, slug: 'support-other-teachers-and-earn-a-stem-community-participation-badge')
  maybe_attach_activity_to_pathway(pathway, slug: 'run-or-support-a-code-club-in-your-school')
  maybe_attach_activity_to_pathway(pathway, slug: 'run-an-enrichment-activity-in-your-classroom')
end
