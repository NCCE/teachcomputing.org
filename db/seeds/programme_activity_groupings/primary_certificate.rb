primary_certificate = Programme.primary_certificate

puts 'Creating Programme Activity Groupings for Primary certificate'

## The numbering of the groupings starts at 2 for historical reasons: group_one with sort_key 1 existed when users were required
## to complete 2 courses, one from each of groups 1 and 2.

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'All courses') do |programme_activity_group|
  programme_activity_group.sort_key = 2
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
  programme_activity_group.progress_bar_title = nil
end

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'Contribute to an online discussion') do |programme_activity_group|
  programme_activity_group.sort_key = 3
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
  programme_activity_group.progress_bar_title = 'Complete professional development'
end

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'Develop your teaching practice') do |programme_activity_group|
  programme_activity_group.sort_key = 4
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
  programme_activity_group.progress_bar_title = 'Develop your teaching practice'
end

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'Develop computing in your community') do |programme_activity_group|
  programme_activity_group.sort_key = 5
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
  programme_activity_group.progress_bar_title = 'Develop computing in your community'
end

puts 'Seeding Programme Activity Groupings for Primary Certificate'

# All Courses

group_two = primary_certificate.programme_activity_groupings.find_by(sort_key: 2)

primary_certificate.activities.courses.each do |activity|
  programme_activity = primary_certificate.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

# Community Achievements

group_three = primary_certificate.programme_activity_groupings.find_by(sort_key: 3)

if activity = Activity.find_by(slug: 'contribute-to-online-discussion')
  programme_activity = primary_certificate.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id) unless group_three.programme_activities.include?(programme_activity)
end

group_four = primary_certificate.programme_activity_groupings.find_by(sort_key: 4)

if activity = Activity.find_by(slug: 'review-a-resource-on-cas')
  programme_activity = primary_certificate.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 1) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'host-or-attend-a-barefoot-workshop')
  programme_activity = primary_certificate.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 2) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'raise-aspirations-with-a-stem-ambassador-visit')
  programme_activity = primary_certificate.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 3) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'attend-a-cas-community-meeting')
  programme_activity = primary_certificate.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 4) unless group_four.programme_activities.include?(programme_activity)
end

group_five = primary_certificate.programme_activity_groupings.find_by(sort_key: 5)

if activity = Activity.find_by(slug: 'run-an-after-school-code-club')
  programme_activity = primary_certificate.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 1) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'lead-a-session-at-a-regional-or-national-conference')
  programme_activity = primary_certificate.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 2) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'lead-a-cas-community-of-practice')
  programme_activity = primary_certificate.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 3) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'providing-additional-support')
  programme_activity = primary_certificate.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 4) unless group_five.programme_activities.include?(programme_activity)
end
