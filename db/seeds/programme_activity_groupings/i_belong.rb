i_belong = Programme.i_belong

puts "Creating Programme Activity Groupings"

## The numbering of the groupings starts at 2 for historical reasons: group_one with sort_key 1 existed when users were required
## to complete 2 courses, one from each of groups 1 and 2.

i_belong.programme_activity_groupings.find_or_initialize_by(sort_key: 2).tap do |group|
  group.sort_key = 2
  group.cms_slug = "i-belong-all-courses"
  group.required_for_completion = 1
  group.programme_id = i_belong.id
  group.progress_bar_title = "<strong>Complete</strong> a recommended course"
  group.title = "Complete a course to understand the factors of girls’ participation in computer science"
  group.web_copy_aside_slug = "i-belong-dashboard-help-section"
  group.save!

  activities = [
    # April 1st course replacements
    {slug: "empowering-girls-in-key-stage-2-computing-online", legacy: false},
    {slug: "encouraging-girls-into-computer-science-online", legacy: false},

    # LEGACY
    {slug: "supporting-the-i-belong-programme", legacy: true},
    {slug: "empowering-girls-in-key-stage-2-computing", legacy: true},
    {slug: "encouraging-girls-into-gcse-computer-science-remote-short-course", legacy: true}
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity[:slug], index + 1, legacy: activity[:legacy])
  end
end.save!

i_belong.programme_activity_groupings.find_or_initialize_by(sort_key: 3).tap do |group|
  group.title = "Access these resources to support you"
  group.sort_key = 3
  group.cms_slug = "i-belong-access-resources"
  group.required_for_completion = 2
  group.programme_id = i_belong.id
  group.progress_bar_title = "<strong>Access</strong> resources to support you"
  group.community = true
  group.web_copy_aside_slug = "i-belong-dashboard-resources"

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
  group.title = "Increase girls' engagement by completing activities"
  group.web_copy_subtitle = "Complete at least one activity. Refer to your handbook for more detailed guidance and resources."
  group.cms_slug = "i-belong-increase-engagement"
  group.sort_key = 4
  group.required_for_completion = 1
  group.programme_id = i_belong.id
  group.progress_bar_title = "<strong>Increase</strong> girls’ engagement by completing activities"
  group.community = true
  group.web_copy_aside_slug = "i-belong-dashboard-increase-engagement"

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
