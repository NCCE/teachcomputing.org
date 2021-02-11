puts 'Creating Pathways for CSA'

pathway = Pathway.find_or_create_by(slug: 'advanced-gcse-computer-science') do |q|
  q.title = 'Advanced GCSE Computer Science'
  q.slug = 'advanced-gcse-computer-science'
  q.range = 0..0
end

# main

activity = Activity.find_by(stem_course_template_no: '03fb0a52-a712-eb11-a813-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1)
end

activity = Activity.find_by(stem_course_template_no: 'e1e54959-db12-eb11-a813-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2)
end

activity = Activity.find_by(future_learn_course_uuid: '645ec51f-0b46-4102-a364-90647057f4f2')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3)
end

activity = Activity.find_by(future_learn_course_uuid: '83c939cf-8aa7-43d9-ad06-acaa3b859d91')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4)
end

# alternative remote

activity = Activity.find_by(stem_course_template_no: '67a21143-4886-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1, supplementary: true)
end

activity = Activity.find_by(stem_course_template_no: '07e76ffd-e17f-ea11-a811-000d3a86f6ce')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2, supplementary: true)
end

activity = Activity.find_by(stem_course_template_no: 'ad8580c0-2915-eb11-a813-000d3a86f6ce')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3, supplementary: true)
end

# alternative online

activity = Activity.find_by(future_learn_course_uuid: '3574403e-a63f-4230-9f4b-3f5b6cd4ddb7')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4, supplementary: true)
end

activity = Activity.find_by(future_learn_course_uuid: '2e1e3f69-b200-4fc7-a6bd-dff682bdd228')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 5, supplementary: true)
end

activity = Activity.find_by(future_learn_course_uuid: '88ad7443-d27a-482c-b2a9-83ddc1357532')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 6, supplementary: true)
end

pathway = Pathway.find_or_create_by(slug: 'prepare-to-teach-gcse-computer-science') do |q|
  q.title = 'Preparing to teach GCSE computer science'
  q.slug = 'prepare-to-teach-gcse-computer-science'
  q.range = 2..10
end

# main

activity = Activity.find_by(stem_course_template_no: '935a0639-e87f-ea11-a811-000d3a86f6ce')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1)
end

activity = Activity.find_by(stem_course_template_no: '770d8136-3d86-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2)
end

activity = Activity.find_by(future_learn_course_uuid: 'c88099c0-8b44-42a5-aad3-0dd011fe3490')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3)
end

activity = Activity.find_by(stem_course_template_no: '07e76ffd-e17f-ea11-a811-000d3a86f6ce')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4)
end

activity = Activity.find_by(future_learn_course_uuid: '04953102-a4cf-485d-a34e-0c64621033be')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 5)
end

activity = Activity.find_by(future_learn_course_uuid: '6c5bddfb-7dd4-467b-9554-34f3aedc233f')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 6)
end

# alternative remote

activity = Activity.find_by(stem_course_template_no: '65fe83ad-b188-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1, supplementary: true)
end

activity = Activity.find_by(stem_course_template_no: '67a21143-4886-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2, supplementary: true)
end

activity = Activity.find_by(stem_course_template_no: '07e76ffd-e17f-ea11-a811-000d3a86f6ce')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3, supplementary: true)
end

# alternative online

activity = Activity.find_by(future_learn_course_uuid: '6c5bddfb-7dd4-467b-9554-34f3aedc233f')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4, supplementary: true)
end

activity = Activity.find_by(future_learn_course_uuid: '6c5bddfb-7dd4-467b-9554-34f3aedc233f')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 5, supplementary: true)
end

pathway = Pathway.find_or_create_by(slug: 'new-to-algorithms-and-programming') do |q|
  q.title = 'New to algorithms and programming'
  q.slug = 'new-to-algorithms-and-programming'
  q.range = 0..0
end

# main

activity = Activity.find_by(stem_course_template_no: '526b3a42-b688-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1)
end

activity = Activity.find_by(stem_course_template_no: '935a0639-e87f-ea11-a811-000d3a86f6ce')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2)
end

activity = Activity.find_by(future_learn_course_uuid: 'c9fb59cc-6393-4a29-8136-7020128ca879')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3)
end

activity = Activity.find_by(future_learn_course_uuid: 'd9fe6126-298f-48ed-8be3-b82e1c473566')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4)
end

# alternative remote

activity = Activity.find_by(stem_course_template_no: '67a21143-4886-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1,
                                               supplementary: true)
end

activity = Activity.find_by(stem_course_template_no: '07e76ffd-e17f-ea11-a811-000d3a86f6ce')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2,
                                               supplementary: true)
end

activity = Activity.find_by(stem_course_template_no: 'e1e54959-db12-eb11-a813-000d3a86d54')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3,
                                               supplementary: true)
end

activity = Activity.find_by(stem_course_template_no: 'ad8580c0-2915-eb11-a813-000d3a86f6ce')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4,
                                               supplementary: true)
end

# alternative online

activity = Activity.find_by(future_learn_course_uuid: '66ceead6-5641-485c-9d10-40a35b8e465e')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 5,
                                               supplementary: true)
end

activity = Activity.find_by(future_learn_course_uuid: 'e290318f-ba23-4c95-8f18-584946233af9')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 6, supplementary: true)
end

pathway = Pathway.find_or_create_by(slug: 'new-to-computing') do |q|
  q.title = 'New to computing'
  q.slug = 'new-to-computing'
  q.range = 0..0
end

# main

activity = Activity.find_by(stem_course_template_no: '526b3a42-b688-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1)
end

activity = Activity.find_by(stem_course_template_no: 'bd6497ad-4386-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2)
end

activity = Activity.find_by(stem_course_template_no: '935a0639-e87f-ea11-a811-000d3a86f6ce')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3)
end

activity = Activity.find_by(future_learn_course_uuid: 'c9fb59cc-6393-4a29-8136-7020128ca879')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4)
end

activity = Activity.find_by(future_learn_course_uuid: 'e4115d3c-53d0-4538-94c2-e2a9ba366178')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 5)
end

activity = Activity.find_by(future_learn_course_uuid: 'c88099c0-8b44-42a5-aad3-0dd011fe3490')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 6)
end

# alternative remote

activity = Activity.find_by(stem_course_template_no: 'dd8a8433-e57f-ea11-a811-000d3a86f6ce')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1,
                                               supplementary: true)
end

activity = Activity.find_by(stem_course_template_no: '07e76ffd-e17f-ea11-a811-000d3a86f6ce')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2,
                                               supplementary: true)
end

activity = Activity.find_by(stem_course_template_no: '65fe83ad-b188-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3,
                                               supplementary: true)
end

# alternative online

activity = Activity.find_by(future_learn_course_uuid: '6c5bddfb-7dd4-467b-9554-34f3aedc233f')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4,
                                               supplementary: true)
end

activity = Activity.find_by(future_learn_course_uuid: 'e290318f-ba23-4c95-8f18-584946233af9')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 5,
                                               supplementary: true)
end

activity = Activity.find_by(future_learn_course_uuid: 'ffc6793d-5643-40c8-893a-0164844ca62f')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 6,
                                               supplementary: true)
end

pathway = Pathway.find_or_create_by(slug: 'new-to-computer-systems') do |q|
  q.title = 'New to computer systems'
  q.slug = 'new-to-computer-systems'
  q.range = 0..0
end

# main

activity = Activity.find_by(stem_course_template_no: 'bd6497ad-4386-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1)
end

activity = Activity.find_by(stem_course_template_no: '65fe83ad-b188-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2)
end

activity = Activity.find_by(future_learn_course_uuid: '6c5bddfb-7dd4-467b-9554-34f3aedc233f')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3)
end

activity = Activity.find_by(future_learn_course_uuid: 'e290318f-ba23-4c95-8f18-584946233af9')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4)
end

# alternative remote

activity = Activity.find_by(stem_course_template_no: 'dd8a8433-e57f-ea11-a811-000d3a86f6ce')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 1,
                                               supplementary: true)
end

activity = Activity.find_by(stem_course_template_no: '770d8136-3d86-ea11-a811-000d3a86d545')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 2,
                                               supplementary: true)
end

# alternative online

activity = Activity.find_by(future_learn_course_uuid: '04953102-a4cf-485d-a34e-0c64621033be')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 3,
                                               supplementary: true)
end

activity = Activity.find_by(future_learn_course_uuid: '030261f8-1e96-4a70-a329-e3eb8b868915')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 4,
                                               supplementary: true)
end

activity = Activity.find_by(future_learn_course_uuid: 'ffc6793d-5643-40c8-893a-0164844ca62f')
if activity && !pathway.pathway_activities.include?(activity)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id, order: 5,
                                               supplementary: true)
end
