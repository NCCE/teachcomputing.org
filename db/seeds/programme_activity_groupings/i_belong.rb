i_belong = Programme.i_belong

puts "Creating Programme Activity Groupings"

## The numbering of the groupings starts at 2 for historical reasons: group_one with sort_key 1 existed when users were required
## to complete 2 courses, one from each of groups 1 and 2.

i_belong.programme_activity_groupings.find_or_initialize_by(title: "all courses").tap do |group|
  group.sort_key = 2
  group.required_for_completion = 1
  group.programme_id = i_belong.id
  group.progress_bar_title = "<strong>Understand</strong> factors affecting girl's participation"

  group.save!

  activities = [
    "encouraging-girls-into-gcse-computer-science-remote-short-course",
    "supporting-the-i-belong-programme"
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity, index + 1)
  end
end.save!

i_belong.programme_activity_groupings.find_or_initialize_by(sort_key: 3).tap do |group|
  group.title = "<strong>Access</strong> and <strong>complete all</strong> of the following activities"
  group.sort_key = 3
  group.required_for_completion = 2
  group.programme_id = i_belong.id
  group.progress_bar_title = "<strong>Access</strong> resources to support you"
  group.community = true

  group.save!

  activities = [
    {slug: "download-and-use-the-i-belong-handbook", legacy: false},
    {slug: "request-your-i-belong-in-computer-science-posters", legacy: false}
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity[:slug], index + 1, legacy: activity[:legacy])
  end
end.save!

i_belong.programme_activity_groupings.find_or_initialize_by(sort_key: 4).tap do |group|
  group.title = "<strong>Increase</strong> girls' engagement"
  group.sort_key = 4
  group.required_for_completion = 1
  group.programme_id = i_belong.id
  group.progress_bar_title = "<strong>Increase</strong> girls’ engagement by completing at least one activity"
  group.community = true

  group.save!

  activities = [
    {slug: "implement-selected-key-stage-3-teach-computing-curriculum-resources", legacy: false},
    {slug: "participate-in-a-ncce-student-enrichment-activity", legacy: false},
    {slug: "provide-access-to-a-computing-related-extracurricular-club", legacy: false},
    {slug: "host-a-computing-stem-ambassador-activity", legacy: false},
    {slug: "participate-in-a-computing-related-competition", legacy: false},
    {slug: "any-other-activity-which-aligns-with-recommendations-from-the-handbook", legacy: false},

    # Legacy

    {slug: "start-or-deliver-a-computing-related-club", legacy: true}
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity[:slug], index + 1, legacy: activity[:legacy])
  end
end.save!
