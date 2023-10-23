puts 'Creating Pathways for CSA'

prog_id = Programmes::CSAccelerator.find_by(slug: 'cs-accelerator').id

Pathway.find_or_initialize_by(slug: 'advanced-gcse-computer-science').tap do |pathway|
  pathway.title = 'Advanced GCSE Computer Science'
  pathway.slug = 'advanced-gcse-computer-science'
  pathway.range = 0..0
  pathway.pdf_link = 'https://static.teachcomputing.org/05_Teaching_advanced_GCSE_computer_science.pdf'
  pathway.programme_id = prog_id
  pathway.order = 5
  pathway.save!

  remove_activities = [
    '03fb0a52-a712-eb11-a813-000d3a86d545',
    'e1e54959-db12-eb11-a813-000d3a86d545',
    '83e7b049-a5b6-ed11-b597-0022481b59ce',
    '7ffcf8be-a6b6-ed11-b597-0022481b59ce',
    'c53a5ed2-3c6e-ec11-8943-000d3a874094',
    '67a21143-4886-ea11-a811-000d3a86d545',
    '07e76ffd-e17f-ea11-a811-000d3a86f6ce',
    'ad8580c0-2915-eb11-a813-000d3a86f6ce',
    '0bccfb49-a6b6-ed11-b597-0022481b59ce',
    'a46bc181-a4b6-ed11-b597-0022481b59ce',
    'ed5a3948-a4b6-ed11-b597-0022481b59ce'
  ]

  remove_activities.each do |activity|
    maybe_detach_activity_from_pathway(pathway, stem_course_template_no: activity)
  end

  activities = %w[
    CP463
    CP464
    CO217
    CO219

    CP420
    CP433
    CO221
    CO210
    CO231
  ]

  activities.each do |activity|
    maybe_attach_activity_to_pathway(pathway, stem_activity_code: activity)
  end
end.save!


Pathway.find_or_initialize_by(slug: 'prepare-to-teach-gcse-computer-science').tap do |pathway|
  pathway.title = 'Preparing to teach GCSE computer science'
  pathway.slug = 'prepare-to-teach-gcse-computer-science'
  pathway.range = 2..10
  pathway.pdf_link = 'https://static.teachcomputing.org/02_Preparing_to_teach_GCSE_computer_science.pdf'
  pathway.programme_id = prog_id
  pathway.order = 4
  pathway.save!

  remove_activities = [
    '935a0639-e87f-ea11-a811-000d3a86f6ce',
    '770d8136-3d86-ea11-a811-000d3a86d545',
    '07e76ffd-e17f-ea11-a811-000d3a86f6ce',
    '249f1bc2-a5b6-ed11-b597-0022481b59ce',
    '9187d975-a6b6-ed11-b597-0022481b59ce',
    '03fb0a52-a712-eb11-a813-000d3a86d545',
    '67a21143-4886-ea11-a811-000d3a86d545',
    'ce24e77f-d312-eb11-a813-000d3a86f6ce',
    'c53a5ed2-3c6e-ec11-8943-000d3a874094',
    '63c44113-a4b6-ed11-b597-0022481b59ce',
    'ac3bf599-a6b6-ed11-b597-0022481b59ce',
  ]

  remove_activities.each do |activity|
    maybe_detach_activity_from_pathway(pathway, stem_course_template_no: activity)
  end

  activities = %w[
    CP223
    CP423
    CP420
    CP432
    CO206
    CO207
    CO213

    CP433
    CP430
    CP434
    CO208
    CO214
    CO216
  ]

  activities.each do |activity|
    maybe_attach_activity_to_pathway(pathway, stem_activity_code: activity)
  end
end.save!

########################################################################################################################

Pathway.find_or_initialize_by(slug: 'new-to-algorithms-and-programming').tap do |pathway|
  pathway.title = 'New to algorithms and programming'
  pathway.slug = 'new-to-algorithms-and-programming'
  pathway.range = 0..0
  pathway.pdf_link = 'https://static.teachcomputing.org/03_New_to_algorithms_and_programming.pdf'
  pathway.programme_id = prog_id
  pathway.order = 2
  pathway.save!

  remove_activities = [
    '526b3a42-b688-ea11-a811-000d3a86d545',
    '935a0639-e87f-ea11-a811-000d3a86f6ce',
    '9187d975-a6b6-ed11-b597-0022481b59ce',
    'ac3bf599-a6b6-ed11-b597-0022481b59ce',
    '07e76ffd-e17f-ea11-a811-000d3a86f6ce',
    '67a21143-4886-ea11-a811-000d3a86d545',
    'e1e54959-db12-eb11-a813-000d3a86d545',
    'ad8580c0-2915-eb11-a813-000d3a86f6ce',
    'ce24e77f-d312-eb11-a813-000d3a86f6ce',
    '7ffcf8be-a6b6-ed11-b597-0022481b59ce',
    '55cc7b90-a5b6-ed11-b597-0022481b59ce',
  ]

  remove_activities.each do |activity|
    maybe_detach_activity_from_pathway(pathway, stem_course_template_no: activity)
  end

  activities = %w[
    CP228
    CP428
    CP223
    CP423
    CP420
    CO207
    CO208

    CP433
    CP430
    CP463
    CO219
    CO213
  ]

  activities.each do |activity|
    maybe_attach_activity_to_pathway(pathway, stem_activity_code: activity)
  end
end.save!

########################################################################################################################

Pathway.find_or_initialize_by(slug: 'new-to-computing').tap do |pathway|
  pathway.title = 'New to computing'
  pathway.slug = 'new-to-computing'
  pathway.range = 0..0
  pathway.pdf_link = 'https://static.teachcomputing.org/01_New_to_computing.pdf'
  pathway.programme_id = prog_id
  pathway.order = 1
  pathway.save!

  remove_activities = [
    '1f24260d-0725-ec11-b6e6-000d3a0cb7ce',
    '526b3a42-b688-ea11-a811-000d3a86d545',
    'bd6497ad-4386-ea11-a811-000d3a86d545',
    '935a0639-e87f-ea11-a811-000d3a86f6ce',
    '249f1bc2-a5b6-ed11-b597-0022481b59ce',
    '9187d975-a6b6-ed11-b597-0022481b59ce',
    '63c44113-a4b6-ed11-b597-0022481b59ce',
    'dd8a8433-e57f-ea11-a811-000d3a86f6ce',
    '07e76ffd-e17f-ea11-a811-000d3a86f6ce',
    '55cc7b90-a5b6-ed11-b597-0022481b59ce',
    'e9cb65af-a4b6-ed11-b597-0022481b59ce',
  ]

  remove_activities.each do |activity|
    maybe_detach_activity_from_pathway(pathway, stem_course_template_no: activity)
  end

  activities = %w[
    CP226
    CP426
    CP228
    CP428
    CP238
    CP438
    CO207
    CO206
    CO209

    CP223
    CP423
    CP420
    CP422
    CO215
    CO212
    CO216
  ]

  activities.each do |activity|
    maybe_attach_activity_to_pathway(pathway, stem_activity_code: activity)
  end
end.save!

########################################################################################################################

Pathway.find_or_initialize_by(slug: 'new-to-computer-systems').tap do |pathway|
  pathway.title = 'New to computer systems'
  pathway.slug = 'new-to-computer-systems'
  pathway.range = 0..0
  pathway.pdf_link = 'https://static.teachcomputing.org/04_New_to_computer_systems.pdf'
  pathway.programme_id = prog_id
  pathway.order = 3
  pathway.save!

  remove_activities = [
    'bd6497ad-4386-ea11-a811-000d3a86d545',
    '55cc7b90-a5b6-ed11-b597-0022481b59ce',
    'dd8a8433-e57f-ea11-a811-000d3a86f6ce',
    'e9cb65af-a4b6-ed11-b597-0022481b59ce',
    '770d8136-3d86-ea11-a811-000d3a86d545',
    '249f1bc2-a5b6-ed11-b597-0022481b59ce',
  ]

  remove_activities.each do |activity|
    maybe_detach_activity_from_pathway(pathway, stem_course_template_no: activity)
  end

  activities = %w[
    CP238
    CP438
    CP422
    CO212
    CO209
    CO213

    CP432
    CP434
    CO206
    CO215
  ]

  activities.each do |activity|
    maybe_attach_activity_to_pathway(pathway, stem_activity_code: activity)
  end
end.save!
