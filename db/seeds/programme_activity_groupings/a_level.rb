a_level = Programme.a_level

puts 'Creating Programme Activity Groupings'

## The numbering of the groupings starts at 2 for historical reasons: group_one with sort_key 1 existed when users were required
## to complete 2 courses, one from each of groups 1 and 2.

a_level.programme_activity_groupings.find_or_initialize_by(title: 'all courses').tap do |group|
  group.sort_key = 2
  group.required_for_completion = 0
  group.programme_id = a_level.id

  group.save

  a_level.activities.courses.each do |activity|
    programme_activity = a_level.programme_activities.find_or_create_by(activity_id: activity.id)
    programme_activity.update(programme_activity_grouping_id: group.id)
  end
end.save
