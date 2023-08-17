i_belong = Programme.i_belong_certificate

puts 'Creating Programme Activity Groupings'

## The numbering of the groupings starts at 2 for historical reasons: group_one with sort_key 1 existed when users were required
## to complete 2 courses, one from each of groups 1 and 2.

i_belong.programme_activity_groupings.find_or_initialize_by(title: 'all courses').tap do |group|
  group.sort_key = 2
  group.required_for_completion = 1
  group.programme_id = i_belong.id
  group.progress_bar_title = 'Understand factors affecting girl\'s participation'

  group.save

  i_belong.activities.courses.each do |activity|
    programme_activity = i_belong.programme_activities.find_or_create_by(activity_id: activity.id)
    programme_activity.update(programme_activity_grouping_id: group.id)
  end
end.save

i_belong.programme_activity_groupings.find_or_initialize_by(title: 'Access the following resources to support you').tap do |group|
  group.sort_key = 3
  group.required_for_completion = 3
  group.programme_id = i_belong.id
  group.progress_bar_title = 'Access resources to support you'

  group.save

  activities = [
    'download-and-use-the-i-belong-handbook',
    'request-your-i-belong-in-computer-science-posters',
    'implement-selected-key-stage-3-teach-computing-curriculum-resources'
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity, index + 1)
  end
end.save

i_belong.programme_activity_groupings.find_or_initialize_by(title: 'Increase girls\' engagement').tap do |group|
  group.sort_key = 4
  group.required_for_completion = 1
  group.programme_id = i_belong.id
  group.progress_bar_title = 'Increase girls’ engagement by completing at least one activity'

  group.save

  activities = [
    'participate-in-a-ncce-student-enrichment-activity',
    'start-or-deliver-a-computing-related-club',
    'host-a-computing-stem-ambassador-activity',
    'participate-in-a-computing-related-competition',
    'any-other-activity-which-aligns-with-recommendations-from-the-handbook'
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity, index + 1)
  end
end.save
