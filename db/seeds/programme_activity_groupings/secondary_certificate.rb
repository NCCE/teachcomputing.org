secondary = Programme.secondary_certificate

puts 'Creating Programme Activity Groupings'

secondary.programme_activity_groupings.find_or_create_by(title: 'Online courses') do |programme_activity_group|
  programme_activity_group.sort_key = 1
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = secondary.id
end

secondary.programme_activity_groupings.find_or_create_by(title: 'Face to face or remote courses') do |programme_activity_group|
  programme_activity_group.sort_key = 2
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = secondary.id
end

secondary.programme_activity_groupings.find_or_create_by(title: 'Develop yourself') do |programme_activity_group|
  programme_activity_group.sort_key = 3
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = secondary.id
end

secondary.programme_activity_groupings.find_or_create_by(title: 'Develop your professional community') do |programme_activity_group|
  programme_activity_group.sort_key = 4
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = secondary.id
end

secondary.programme_activity_groupings.find_or_create_by(title: 'Develop your students') do |programme_activity_group|
  programme_activity_group.sort_key = 5
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = secondary.id
end

puts 'Seeding Programme Activity Groupings for Secondary'

group_one = secondary.programme_activity_groupings.find_by(sort_key: 1)

# Online/Future Learn courses

if activity = Activity.find_by(future_learn_course_uuid: 'ecf78d20-2966-4798-af5f-0f869c1818e2')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: '3ce9a624-6cc7-4d23-8f5f-95162e360178')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: 'b19646a7-d78b-4a92-ad36-d4b3a11a3df1')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: '6cd40c14-adbf-4da7-af81-849d0f74a2fe')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: '7e5ae100-f4fc-425b-a53b-c81cb6eb4abc')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: '8a38adaf-9a03-414a-ad9f-c0b5a9f347f1')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: 'be2ded42-3fbd-eb11-bacc-0022481a6a2c')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(future_learn_course_uuid: '0fbfa644-501d-4ac0-b3ef-3cc458d33527')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

# STEM Learning Courses

group_two = secondary.programme_activity_groupings.find_by(sort_key: 2)

if activity = Activity.find_by(stem_course_template_no: 'b7f3eb4b-42d3-eb11-bacb-0022481aa15a')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '22880db7-78e8-ea11-a817-000d3a86f6ce')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '1dcba944-6ae9-4b68-af69-56df49495bd7')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '26c20962-6279-4927-b797-42363848130c')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '258c93cc-69e2-46f6-bf39-fbce27cb8fc2')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '3b2957a3-3541-eb11-a813-000d3a86d545')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: 'c9957d36-3841-eb11-a813-000d3a86d545')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '15040292-3941-eb11-a813-000d3a86d545')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '6e8bfcd4-df50-eb11-a812-000d3a86f6ce')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '1a81f632-a255-eb11-a812-000d3a874628')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '5b1b5967-7c6c-eb11-a812-000d3a872800')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: 'bacc4ebb-eb8a-eb11-b1ac-0022481a662d')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: 'd35ce2c2-e78a-eb11-b1ac-0022481a662d')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: 'be2eae05-828c-eb11-b1ac-0022481a6ad5')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: 'aafe379e-9e8c-eb11-b1ac-0022481a6ffe')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '6172f084-b38c-eb11-b1ac-0022481a6ffe')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: 'be2ded42-3fbd-eb11-bacc-0022481a6a2c')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '1b149049-2f19-eb11-a813-000d3a86f6ce')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(stem_course_template_no: '576c1f0b-8610-ec11-b6e6-000d3a0cc552')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

group_three = secondary.programme_activity_groupings.find_by(sort_key: 3)

if activity = Activity.find_by(slug: 'contribute-to-online-discussion-secondary')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id) unless group_three.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'provide-feedback-on-our-curriculum-resources')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id) unless group_three.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'provide-feedback-on-a-cas-resource')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id) unless group_three.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'complete-a-cs-accelerator-course')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id) unless group_three.programme_activities.include?(programme_activity)
end

group_four = secondary.programme_activity_groupings.find_by(sort_key: 4)

if activity = Activity.find_by(slug: 'provide-computing-cpd-in-your-school-or-to-another-local-school')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'become-a-mentor')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'lead-a-session-at-a-regional-or-national-conference-secondary')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'lead-a-cas-community-of-practice-secondary')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'give-additional-support-to-your-community')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

group_five = secondary.programme_activity_groupings.find_by(sort_key: 5)

if activity = Activity.find_by(slug: 'join-gender-balance-in-computing-programme')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'join-isaac-and-volunteer-to-run-an-event')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'engage-with-stem-ambassadors')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'run-a-code-club-or-coder-dojo')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id) unless group_five.programme_activities.include?(programme_activity)
end
