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

# Online courses TBC

group_two = secondary.programme_activity_groupings.find_by(sort_key: 2)


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

group_three = secondary.programme_activity_groupings.find_by(sort_key: 3)

if activity = Activity.find_by(slug: 'contribute-to-online-discussion')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id) unless group_three.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'download-use-and-provide-meaningful-feedback-on-a-resource-from-the-teach-computing-curriculum')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id) unless group_three.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'review-a-resource-on-cas')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id) unless group_three.programme_activities.include?(programme_activity)
end

group_four = secondary.programme_activity_groupings.find_by(sort_key: 4)

if activity = Activity.find_by(slug: 'provide-computing-cpd-in-your-school-or-to-another-local-school')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'become-a-mentor-support-another-teacher-through-the-cs-accelerator-programme-support-a-trainee-teacher')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'lead-a-session-at-a-regional-or-national-conference')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'lead-a-cas-community-of-practice')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'give-additional-support-beyond-your-day-to-day-teaching-to-your-local-community-of-teachers-pupils-or-parents')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id) unless group_four.programme_activities.include?(programme_activity)
end

group_five = secondary.programme_activity_groupings.find_by(sort_key: 5)

if activity = Activity.find_by(slug: 'register-to-participate-in-the-gender-balance-in-computing-programme')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'volunteer-to-run-an-event-with-the-isaac-computer-science-programme')
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
