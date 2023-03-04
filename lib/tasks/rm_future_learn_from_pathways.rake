namespace :rm_future_learn_from_pathways do
  desc 'one-off task to remove the future learn courses from their pathways'
  task remove: :environment do
    puts 'Destroying pathway join records for all future learn courses'
    PathwayActivity.joins(:activity).where(activity: Activity.future_learn).delete_all
  end

  desc 'one-off task to restore known future learn courses to their pathways'
  task restore: :environment do
    puts 'Creating FL pathway activities for CSA - Advanced GCSE Computer Science'
    pathway = Pathway.find_by(slug: 'advanced-gcse-computer-science')
    # main
    activity = Activity.find_by(future_learn_course_uuid: '645ec51f-0b46-4102-a364-90647057f4f2')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity
    activity = Activity.find_by(future_learn_course_uuid: '83c939cf-8aa7-43d9-ad06-acaa3b859d91')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity
    # alternative online
    activity = Activity.find_by(future_learn_course_uuid: '3574403e-a63f-4230-9f4b-3f5b6cd4ddb7')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    activity = Activity.find_by(future_learn_course_uuid: '2e1e3f69-b200-4fc7-a6bd-dff682bdd228')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    activity = Activity.find_by(future_learn_course_uuid: '88ad7443-d27a-482c-b2a9-83ddc1357532')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    #------------------------------------------------------------------------#
    puts 'Creating FL pathway activities for CSA - Preparing GCSE Computer Science'
    pathway = Pathway.find_by(slug: 'prepare-to-teach-gcse-computer-science')
    # main
    activity = Activity.find_by(future_learn_course_uuid: 'c88099c0-8b44-42a5-aad3-0dd011fe3490')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity
    activity = Activity.find_by(future_learn_course_uuid: '04953102-a4cf-485d-a34e-0c64621033be')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity
    activity = Activity.find_by(future_learn_course_uuid: '6c5bddfb-7dd4-467b-9554-34f3aedc233f')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity
    # alternative online
    activity = Activity.find_by(future_learn_course_uuid: 'ffc6793d-5643-40c8-893a-0164844ca62f')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    activity = Activity.find_by(future_learn_course_uuid: 'd9fe6126-298f-48ed-8be3-b82e1c473566')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    #------------------------------------------------------------------------#
    puts 'Creating FL pathway activities for CSA - new to algorithms and programming'
    pathway = Pathway.find_by(slug: 'new-to-algorithms-and-programming')
    # main
    activity = Activity.find_by(future_learn_course_uuid: 'c9fb59cc-6393-4a29-8136-7020128ca879')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity
    activity = Activity.find_by(future_learn_course_uuid: 'd9fe6126-298f-48ed-8be3-b82e1c473566')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity
    # alternative online
    activity = Activity.find_by(future_learn_course_uuid: '66ceead6-5641-485c-9d10-40a35b8e465e')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    activity = Activity.find_by(future_learn_course_uuid: 'e290318f-ba23-4c95-8f18-584946233af9')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    #------------------------------------------------------------------------#
    puts 'Creating FL pathway activities for CSA - new to computing'
    pathway = Pathway.find_by(slug: 'new-to-computing')
    # main
    activity = Activity.find_by(future_learn_course_uuid: 'c88099c0-8b44-42a5-aad3-0dd011fe3490')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity
    activity = Activity.find_by(future_learn_course_uuid: 'c9fb59cc-6393-4a29-8136-7020128ca879')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity
    activity = Activity.find_by(future_learn_course_uuid: 'e4115d3c-53d0-4538-94c2-e2a9ba366178')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity
    # alternative online
    activity = Activity.find_by(future_learn_course_uuid: '6c5bddfb-7dd4-467b-9554-34f3aedc233f')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    activity = Activity.find_by(future_learn_course_uuid: 'e290318f-ba23-4c95-8f18-584946233af9')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    activity = Activity.find_by(future_learn_course_uuid: 'ffc6793d-5643-40c8-893a-0164844ca62f')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    #------------------------------------------------------------------------#
    puts 'Creating FL pathway activities for CSA - new to computer systems'
    pathway = Pathway.find_by(slug: 'new-to-computer-systems')
    # main
    activity = Activity.find_by(future_learn_course_uuid: '6c5bddfb-7dd4-467b-9554-34f3aedc233f')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity
    activity = Activity.find_by(future_learn_course_uuid: 'e290318f-ba23-4c95-8f18-584946233af9')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity
    # alternative online
    activity = Activity.find_by(future_learn_course_uuid: '04953102-a4cf-485d-a34e-0c64621033be')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    activity = Activity.find_by(future_learn_course_uuid: '030261f8-1e96-4a70-a329-e3eb8b868915')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    activity = Activity.find_by(future_learn_course_uuid: 'ffc6793d-5643-40c8-893a-0164844ca62f')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id, supplementary: true) if activity
    #------------------------------------------------------------------------#
    puts 'Creating FL pathway activities for Primary Certificate - developing in the classroom'
    pathway = Pathway.find_by(slug: 'developing-in-the-classroom')
    activity = Activity.find_by(future_learn_course_uuid: '147b3adf-9f26-4ffa-a95f-6c1720ca4d27')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)
    activity = Activity.find_by(future_learn_course_uuid: '7f88c178-9538-4970-b438-ab80e6125d5e')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)
    activity = Activity.find_by(future_learn_course_uuid: 'b2445d09-f3b3-45da-b4ec-6d33bb6cb89b')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)
    activity = Activity.find_by(future_learn_course_uuid: 'b19646a7-d78b-4a92-ad36-d4b3a11a3df1')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)
    #------------------------------------------------------------------------#
    puts 'Creating FL pathway activities for Primary Certificate - specialising or leading'
    pathway = Pathway.find_by(slug: 'specialising-or-leading')
    activity = Activity.find_by(future_learn_course_uuid: '26e9cd23-2d71-4964-9af3-751aa3fdc8e5')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)
    activity = Activity.find_by(future_learn_course_uuid: '440d652-4128-4995-9ef7-662a0bc505ed')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)
    activity = Activity.find_by(future_learn_course_uuid: '7e5ae100-f4fc-425b-a53b-c81cb6eb4abc')
    pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)
  end
end
