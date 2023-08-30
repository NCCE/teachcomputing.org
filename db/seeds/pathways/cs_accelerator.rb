puts 'Creating Pathways for CSA'

prog_id = Programmes::CSAccelerator.find_by(slug: 'cs-accelerator').id

pathway = Pathway.find_or_initialize_by(slug: 'advanced-gcse-computer-science')
pathway.update(
  title: 'Advanced GCSE Computer Science',
  slug: 'advanced-gcse-computer-science',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/05_Teaching_advanced_GCSE_computer_science.pdf',
  programme_id: prog_id,
  order: 5
)

# main

activity = Activity.find_by(stem_course_template_no: '03fb0a52-a712-eb11-a813-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: 'e1e54959-db12-eb11-a813-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '83e7b049-a5b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '7ffcf8be-a6b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

# CP478/supporting-gcse-computer-science-students-at-grades-1-3
activity = Activity.find_by(stem_course_template_no: 'c53a5ed2-3c6e-ec11-8943-000d3a874094')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

# alternative remote

activity = Activity.find_by(stem_course_template_no: '67a21143-4886-ea11-a811-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

activity = Activity.find_by(stem_course_template_no: '07e76ffd-e17f-ea11-a811-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

activity = Activity.find_by(stem_course_template_no: 'ad8580c0-2915-eb11-a813-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

# alternative online

# CO221/introduction-to-web-development
activity = Activity.find_by(stem_course_template_no: '0bccfb49-a6b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

# CO210/object-oriented-programming-in-python-create-your-own-adventure-game
activity = Activity.find_by(stem_course_template_no: 'a46bc181-a4b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

# CO225/introduction-to-databases-and-sql
activity = Activity.find_by(stem_course_template_no: 'ed5a3948-a4b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

########################################################################################################################

pathway = Pathway.find_or_initialize_by(slug: 'prepare-to-teach-gcse-computer-science')
pathway.update(
  title: 'Preparing to teach GCSE computer science',
  slug: 'prepare-to-teach-gcse-computer-science',
  range: 2..10,
  pdf_link: 'https://static.teachcomputing.org/02_Preparing_to_teach_GCSE_computer_science.pdf',
  programme_id: prog_id,
  order: 4
)

# main

activity = Activity.find_by(stem_course_template_no: '935a0639-e87f-ea11-a811-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '770d8136-3d86-ea11-a811-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '07e76ffd-e17f-ea11-a811-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '249f1bc2-a5b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '9187d975-a6b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

# CP439/higher-attainment-in-computer-science-meeting-the-challenges-of-the-exams-remote
activity = Activity.find_by(stem_course_template_no: '03fb0a52-a712-eb11-a813-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity


# alternative remote

activity = Activity.find_by(stem_course_template_no: '67a21143-4886-ea11-a811-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

activity = Activity.find_by(stem_course_template_no: 'ce24e77f-d312-eb11-a813-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

# CP478/supporting-gcse-computer-science-students-at-grades-1-3
activity = Activity.find_by(stem_course_template_no: 'c53a5ed2-3c6e-ec11-8943-000d3a874094')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

# alternative online

activity = Activity.find_by(stem_course_template_no: '63c44113-a4b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

activity = Activity.find_by(stem_course_template_no: 'ac3bf599-a6b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

########################################################################################################################

pathway = Pathway.find_or_initialize_by(slug: 'new-to-algorithms-and-programming')
pathway.update(
  title: 'New to algorithms and programming',
  slug: 'new-to-algorithms-and-programming',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/03_New_to_algorithms_and_programming.pdf',
  programme_id: prog_id,
  order: 2
)

# main

activity = Activity.find_by(stem_course_template_no: '526b3a42-b688-ea11-a811-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '935a0639-e87f-ea11-a811-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '9187d975-a6b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: 'ac3bf599-a6b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

# CP420/representing-algorithms-using-flowcharts-and-pseudocode-remote
activity = Activity.find_by(stem_course_template_no: '07e76ffd-e17f-ea11-a811-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

# alternative remote

activity = Activity.find_by(stem_course_template_no: '67a21143-4886-ea11-a811-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

# CP463/python-programming-advanced-subject-knowledge-implementation-and-testing-remote
activity = Activity.find_by(stem_course_template_no: 'e1e54959-db12-eb11-a813-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

activity = Activity.find_by(stem_course_template_no: 'ad8580c0-2915-eb11-a813-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

# CP430/search-and-sort-algorithms-remote
activity = Activity.find_by(stem_course_template_no: 'ce24e77f-d312-eb11-a813-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

# alternative online

activity = Activity.find_by(stem_course_template_no: '7ffcf8be-a6b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

activity = Activity.find_by(stem_course_template_no: '55cc7b90-a5b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

########################################################################################################################

pathway = Pathway.find_or_initialize_by(slug: 'new-to-computing')
pathway.update(
  title: 'New to computing',
  slug: 'new-to-computing',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/01_New_to_computing.pdf',
  programme_id: prog_id,
  order: 1
)

# main

activity = Activity.find_by(stem_course_template_no: '1f24260d-0725-ec11-b6e6-000d3a0cb7ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '526b3a42-b688-ea11-a811-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: 'bd6497ad-4386-ea11-a811-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '935a0639-e87f-ea11-a811-000d3a86f6ce')
if activity
  pathway.pathway_activities.find_or_initialize_by(activity_id: activity.id).tap do |pa|
    pa.supplementary = true
    pa.save
  end
end

# CO206/how-computers-work-demystifying-computation
activity = Activity.find_by(stem_course_template_no: '249f1bc2-a5b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '9187d975-a6b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '63c44113-a4b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

# alternative remote

activity = Activity.find_by(stem_course_template_no: 'dd8a8433-e57f-ea11-a811-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

activity = Activity.find_by(stem_course_template_no: '07e76ffd-e17f-ea11-a811-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

# alternative online

activity = Activity.find_by(stem_course_template_no: '55cc7b90-a5b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

activity = Activity.find_by(stem_course_template_no: 'e9cb65af-a4b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

########################################################################################################################

pathway = Pathway.find_or_initialize_by(slug: 'new-to-computer-systems')
pathway.update(
  title: 'New to computer systems',
  slug: 'new-to-computer-systems',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/04_New_to_computer_systems.pdf',
  programme_id: prog_id,
  order: 3
)

# main

activity = Activity.find_by(stem_course_template_no: 'bd6497ad-4386-ea11-a811-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: '55cc7b90-a5b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

# CP422/fundamentals-of-computer-networks-remote
activity = Activity.find_by(stem_course_template_no: 'dd8a8433-e57f-ea11-a811-000d3a86f6ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

activity = Activity.find_by(stem_course_template_no: 'e9cb65af-a4b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity

# alternative remote

activity = Activity.find_by(stem_course_template_no: '770d8136-3d86-ea11-a811-000d3a86d545')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

# alternative online

activity = Activity.find_by(stem_course_template_no: '249f1bc2-a5b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity

activity = Activity.find_by(stem_course_template_no: '63c44113-a4b6-ed11-b597-0022481b59ce')
pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
