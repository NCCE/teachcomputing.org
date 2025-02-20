secondary = Programme.secondary_certificate

puts "Creating Programme Activity Groupings for Secondary"

## The numbering of the groupings starts at 2 for historical reasons: group_one with sort_key 1 existed when users were required
## to complete 2 courses, one from each of groups 1 and 2.

secondary.programme_activity_groupings.find_or_initialize_by(title: "All courses").becomes!(ProgrammeActivityGroupings::CreditCounted).tap do |group|
  group.sort_key = 2
  group.cms_slug = "secondary-all-courses"
  group.required_for_completion = 1
  group.programme_id = secondary.id
  group.progress_bar_title = "Complete professional development"
  group.web_copy_course_requirements = "Complete one full day face-to-face, remote or online course, or a combination of short courses that amounts to 6+ hours of professional development."
  group.required_credit_count = 50

  group.save!

  secondary.activities.courses.each do |activity|
    programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
    programme_activity.update(programme_activity_grouping_id: group.id) unless group.programme_activities.include?(programme_activity)
  end
end.save!

secondary.programme_activity_groupings.find_by(title: "Develop your subject knowledge")&.destroy
secondary.programme_activity_groupings.find_by(title: "Develop your teaching practice")&.destroy
secondary.programme_activity_groupings.find_by(title: "Develop computing in your community")&.destroy

secondary.programme_activity_groupings.find_or_initialize_by(title: "Make a positive impact on young people in computing").tap do |group|
  group.title = "Make a positive impact on young people in computing"
  group.sort_key = 3
  group.cms_slug = "secondary-positive-impact"
  group.required_for_completion = 1
  group.programme_id = secondary.id
  group.community = true
  group.progress_bar_title = "Make an impact on young people in computing"
  group.web_copy_course_requirements = "Choose at least one activity"

  group.save!

  # Activities should never be removed, only marked as legacy
  activities = [
    {slug: "raise-aspirations-with-a-stem-ambassador-visit", legacy: false},
    {slug: "participate-fully-in-an-ncce-curriculum-enrichment-oppertunity", legacy: false},
    {slug: "implement-your-professional-development-in-the-classroom-and-evaluate-via-the-impact-toolkit", legacy: false},
    {slug: "download-and-use-isaac-computer-science-classroom-resources-and-displays", legacy: false},
    {slug: "download-and-use-the-ncce-teaching-and-assessment-resources-in-your-classroom", legacy: false},
    {slug: "complete-the-i-belong-programme-as-a-school", legacy: false},

    # Legacy activities
    {slug: "provide-feedback-on-our-curriculum-resources", legacy: true},
    {slug: "provide-feedback-on-a-cas-resource", legacy: true},
    {slug: "complete-a-cs-accelerator-course", legacy: true},
    {slug: "contribute-to-online-discussion-secondary", legacy: true},
    {slug: "join-the-ib-encouraging-girls-into-cs-programme-and-become-an-ibc", legacy: true}
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity[:slug], index + 1, legacy: activity[:legacy])
  end
end.save!

secondary.programme_activity_groupings.find_or_initialize_by(title: "Support your professional community").tap do |group|
  group.title = "Support your professional community"
  group.cms_slug = "secondary-support-community"
  group.sort_key = 4
  group.required_for_completion = 1
  group.programme_id = secondary.id
  group.community = true
  group.progress_bar_title = "Support your professional community"
  group.web_copy_course_requirements = "Choose at least one activity"

  group.save!

  # Activities should never be removed, only marked as legacy
  activities = [
    {slug: "gain-accreditation-as-a-professional-development-leader", legacy: false},
    {slug: "work-with-local-business-and-industry-to-inspire-inclusive-computing", legacy: false},
    {slug: "lead-your-school-into-a-computing-cluster-and-develop-an-action-plan-with-a-cluster-advisor", legacy: false},
    {slug: "join-and-present-at-your-local-computing-at-school-community", legacy: false},
    {slug: "become-an-i-belong-champion", legacy: false},
    {slug: "undertake-the-initial-assessment-of-your-school-using-computing-quality-framework", legacy: false},
    {slug: "support-other-teachers-and-earn-a-stem-community-participation-badge-secondary", legacy: false},

    # Legacy activities
    {slug: "gain-accreditation-as-an-i-belong-champion", legacy: true},
    {slug: "support-other-teachers-and-earn-a-stem-community-participation-badge", legacy: true},
    {slug: "provide-feedback-on-our-curriculum-resources", legacy: true},
    {slug: "provide-feedback-on-a-cas-resource", legacy: true},
    {slug: "complete-a-cs-accelerator-course", legacy: true},
    {slug: "contribute-to-online-discussion-secondary", legacy: true},

    {slug: "work-with-your-local-computing-hub-to-develop-a-school-level-action-plan-for-professional-development", legacy: true}
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity[:slug], index + 1, legacy: activity[:legacy])
  end
end.save!
