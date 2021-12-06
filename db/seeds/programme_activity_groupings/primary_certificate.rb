primary_certificate = Programme.primary_certificate

puts 'Creating Programme Activity Groupings for Primary certificate'

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'Online courses') do |programme_activity_group|
  programme_activity_group.sort_key = 1
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
end

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'Face to face or remote courses') do |programme_activity_group|
  programme_activity_group.sort_key = 2
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
end

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'Contribute to an online discussion') do |programme_activity_group|
  programme_activity_group.sort_key = 3
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
end

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'develop your teaching practice') do |programme_activity_group|
  programme_activity_group.sort_key = 3
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
end

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'develop computing in your community') do |programme_activity_group|
  programme_activity_group.sort_key = 3
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
end

puts 'Seeding Programme Activity Groupings for Primary Certificate'

group_one = primary_certificate.programme_activity_groupings.find_by(sort_key: 1)

# Online/Future Learn courses

if activity = Activity.find_by(future_learn_course_uuid: '7e5ae100-f4fc-425b-a53b-c81cb6eb4abc')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: 'bc7debb8-59a0-4d4a-8d86-082047bf155f')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: 'b19646a7-d78b-4a92-ad36-d4b3a11a3df1')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: '4ec560a3-6435-46bc-90b7-75cfdcf7e72d')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: '147b3adf-9f26-4ffa-a95f-6c1720ca4d27')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: '7f88c178-9538-4970-b438-ab80e6125d5e')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: 'b2445d09-f3b3-45da-b4ec-6d33bb6cb89b')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: 'c9fb59cc-6393-4a29-8136-7020128ca879')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: '3ce9a624-6cc7-4d23-8f5f-95162e360178')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: '26e9cd23-2d71-4964-9af3-751aa3fdc8e5')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: 'd440d652-4128-4995-9ef7-662a0bc505ed')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

# STEM Learning Courses

group_two = programme_activity.programme_activity_groupings.find_by(sort_key: 2)

if activity = Activity.find_by(stem_course_template_no: 'e5acc943-4926-ea11-a810-000d3a86d545')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '68f5b6c5-556d-4b66-8159-7cd6019da6f3')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '488bed9b-515b-4295-a488-62b5bb6bf852')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '16aeecbd-d202-4f42-bad3-f86c8f671547')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '34ff2768-a7fc-ea11-a813-000d3a86d545')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: 'e3c14378-3015-eb11-a813-000d3a86f6ce')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '11f58c3f-3341-eb11-a813-000d3a86d545')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: 'bb7a0f31-5086-ea11-a811-000d3a86d545')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '3bff03fd-256d-eb11-a812-000d3a872640')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '6bc40e34-4c86-ea11-a811-000d3a86d545')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: 'e432e725-ba7f-ea11-a811-000d3a86d545')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '5b694e80-ce7f-ea11-a811-000d3a86d545')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: 'a533bf46-d17f-ea11-a811-000d3a86d545')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '5fdb7188-dd7f-ea11-a811-000d3a86f6ce')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end


if activity = Activity.find_by(stem_course_template_no: 'ee8a70b8-1607-ec11-b6e6-000d3a86d86c')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '88975226-811c-ec11-b6e7-0022481a8033')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

group_three = primary_certificate.programme_activity_groupings.find_by(sort_key: 3)

if activity = Activity.find_by(slug: 'contribute-to-online-discussion')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id) unless group_three.programme_activities.include?(programme_activity)
end

group_four = primary_certificate.programme_activity_groupings.find_by(sort_key: 4)


if activity = Activity.find_by(slug: 'review-a-resource-on-cas')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'host-or-attend-a-barefoot-workshop')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'engage-with-stem-ambassadors')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'attend-a-cas-community-meeting')
  programme_activity = primary_certificate.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

group_five = secondary.programme_activity_groupings.find_by(sort_key: 5)

if activity = Activity.find_by(slug: 'run-an-after-school-code-club')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'lead-a-session-at-a-regional-or-national-conference')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'lead-a-cas-community-of-practice')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'providing-additional-support')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id) unless group_five.programme_activities.include?(programme_activity)
end
