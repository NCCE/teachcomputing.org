i_belong = Programme.i_belong_certificate

puts 'Creating Programme Activity Groupings'

## The numbering of the groupings starts at 2 for historical reasons: group_one with sort_key 1 existed when users were required
## to complete 2 courses, one from each of groups 1 and 2.

i_belong.programme_activity_groupings.find_or_initialize_by(title: 'all courses').tap do |programme_activity_group|
  programme_activity_group.sort_key = 2
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = i_belong.id
  programme_activity_group.save
end

i_belong.programme_activity_groupings.find_or_initialize_by(title: 'Access the following resources to support you').tap do |programme_activity_group|
  programme_activity_group.sort_key = 3
  programme_activity_group.required_for_completion = 3
  programme_activity_group.programme_id = i_belong.id
  programme_activity_group.save
end

i_belong.programme_activity_groupings.find_or_initialize_by(title: 'Increase girls\' engagement').tap do |programme_activity_group|
  programme_activity_group.sort_key = 4
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = i_belong.id
  programme_activity_group.save
end

puts 'Seeding Programme Activity Groupings for I Belong'

# Courses

group_two = i_belong.programme_activity_groupings.find_by(sort_key: 2)

i_belong.activities.courses.each do |activity|
  programme_activity = i_belong.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id)
end

# Community Achievements

group_three = i_belong.programme_activity_groupings.find_by(sort_key: 3)

if activity = Activity.find_by(slug: 'download-and-use-the-i-belong-handbook')
  programme_activity = i_belong.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id, order: 1)
end

if activity = Activity.find_by(slug: 'request-your-i-belong-in-computer-science-posters')
  programme_activity = i_belong.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id, order: 2)
end

if activity = Activity.find_by(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources')
  programme_activity = i_belong.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id, order: 3)
end

group_four = i_belong.programme_activity_groupings.find_by(sort_key: 4)

if activity = Activity.find_by(slug: 'participate-in-a-ncce-student-enrichment-activity')
  programme_activity = i_belong.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 1)
end

if activity = Activity.find_by(slug: 'start-or-deliver-a-computing-related-club')
  programme_activity = i_belong.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 2)
end

if activity = Activity.find_by(slug: 'host-a-computing-stem-ambassador-activity')
  programme_activity = i_belong.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 3)
end

if activity = Activity.find_by(slug: 'participate-in-a-computing-related-competition')
  programme_activity = i_belong.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 4)
end

if activity = Activity.find_by(slug: 'any-other-activity-which-aligns-with-recommendations-from-the-handbook')
  programme_activity = i_belong.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 5)
end
