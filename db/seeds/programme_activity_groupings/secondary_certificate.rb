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

secondary.programme_activity_groupings.find_or_create_by(title: 'Develop your subject knowledge') do |programme_activity_group|
  programme_activity_group.sort_key = 3
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = secondary.id
end

secondary.programme_activity_groupings.find_or_create_by(title: 'Develop your teaching practice') do |programme_activity_group|
  programme_activity_group.sort_key = 4
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = secondary.id
end

secondary.programme_activity_groupings.find_or_create_by(title: 'Develop computing in your community') do |programme_activity_group|
  programme_activity_group.sort_key = 5
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = secondary.id
end

puts 'Seeding Programme Activity Groupings for Secondary'

# Online/Future Learn courses

group_one = secondary.programme_activity_groupings.find_by(sort_key: 1)

secondary.activities.online.each do |activity|
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_one.id) unless group_one.programme_activities.include?(programme_activity)
end

# STEM Learning Courses

group_two = secondary.programme_activity_groupings.find_by(sort_key: 2)

# The face_to_face category covers remote too (as we have no specific remote category)
secondary.activities.face_to_face.each do |activity|
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

# Community Achievements

group_three = secondary.programme_activity_groupings.find_by(sort_key: 3)

if activity = Activity.find_by(slug: 'provide-feedback-on-our-curriculum-resources')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id, order: 1) unless group_three.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'provide-feedback-on-a-cas-resource')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id, order: 2) unless group_three.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'complete-a-cs-accelerator-course')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id, order: 3) unless group_three.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'contribute-to-online-discussion-secondary')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id, order: 4) unless group_three.programme_activities.include?(programme_activity)
end

group_four = secondary.programme_activity_groupings.find_by(sort_key: 4)

if activity = Activity.find_by(slug: 'engage-with-stem-ambassadors')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 1) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'answer-5-questions-on-isaac-computer-science')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 2) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'run-a-code-club-or-coder-dojo')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 3) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'join-gender-balance-in-computing-programme')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 4) unless group_four.programme_activities.include?(programme_activity)
end

group_five = secondary.programme_activity_groupings.find_by(sort_key: 5)

if activity = Activity.find_by(slug: 'provide-computing-cpd-in-your-school-or-to-another-local-school')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 1) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'become-a-mentor')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 2) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'give-additional-support-to-your-community')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 3) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'lead-a-session-at-a-regional-or-national-conference-secondary')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 4) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'lead-a-cas-community-of-practice-secondary')
  programme_activity = secondary.programme_activities.find_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 5) unless group_five.programme_activities.include?(programme_activity)
end
