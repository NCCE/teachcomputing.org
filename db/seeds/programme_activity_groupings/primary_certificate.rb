primary_certificate = Programme.primary_certificate

puts "Creating Programme Activity Groupings for Primary certificate"

## The numbering of the groupings starts at 2 for historical reasons: group_one with sort_key 1 existed when users were required
## to complete 2 courses, one from each of groups 1 and 2.

primary_certificate.programme_activity_groupings.find_or_initialize_by(title: "All courses").becomes!(ProgrammeActivityGroupings::CreditCounted).tap do |group|
  group.sort_key = 2
  group.required_for_completion = 1
  group.programme_id = primary_certificate.id
  group.progress_bar_title = "Complete professional development"
  group.web_copy_course_requirements = "Complete one full day face-to-face, remote or online course, or a combination of short courses that amounts to 6+ hours of professional development."
  group.required_credit_count = 50

  group.save!

  primary_certificate.activities.courses.each do |activity|
    programme_activity = primary_certificate.programme_activities.find_or_create_by(activity_id: activity.id)
    programme_activity.update(programme_activity_grouping_id: group.id) unless group.programme_activities.include?(programme_activity)
  end
end.save!

ProgrammeActivityGrouping.find_by(title: "Contribute to an online discussion")&.destroy

primary_certificate.programme_activity_groupings.find_or_initialize_by(title: "Develop your teaching practice").tap do |group|
  group.sort_key = 3
  group.required_for_completion = 1
  group.programme_id = primary_certificate.id
  group.community = true
  group.progress_bar_title = "Develop your teaching practice"
  group.web_copy_course_requirements = "Choose at least one activity"
  group.web_copy_completion_instruction = "Enable you to develop your teaching expertise and make a positive impact on young people in computing"
  group.web_copy_aside_slug = "primary-dashboard-step-2-section"
  group.web_copy_subtitle = "Step two: Putting it into practice"

  group.save!

  # Activities should never be removed, only marked as legacy
  activities = [
    {slug: "raise-aspirations-with-a-stem-ambassador-visit", legacy: false},
    {slug: "participate-fully-in-an-ncce-curriculum-enrichment-oppertunity-primary", legacy: false},
    {slug: "implement-your-professional-development-in-the-classroom-and-evaluate-via-the-impact-toolkit", legacy: false},
    {slug: "download-and-use-the-ncce-teaching-and-assessment-resources-in-your-classroom", legacy: false},
    {slug: "complete-the-i-belong-programme-as-a-school-primary", legacy: false},

    # Legacy activities
    {slug: "review-a-resource-on-cas", legacy: true},
    {slug: "host-or-attend-a-barefoot-workshop", legacy: true},
    {slug: "attend-a-cas-community-meeting", legacy: true},
    {slug: "participate-fully-in-an-ncce-curriculum-enrichment-oppertunity", legacy: true}
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity[:slug], index + 1, legacy: activity[:legacy])
  end
end.save!

primary_certificate.programme_activity_groupings.find_or_initialize_by(title: "Develop computing in your community").tap do |group|
  group.sort_key = 4
  group.required_for_completion = 1
  group.programme_id = primary_certificate.id
  group.community = true
  group.progress_bar_title = "Develop computing in your community"
  group.web_copy_course_requirements = "Choose at least one activity"
  group.web_copy_subtitle = "Step three: Sharing with others"

  group.save!

  # Activities should never be removed, only marked as legacy
  activities = [
    {slug: "share-tips-on-using-an-ncce-resource-in-your-classroom-with-colleagues-on-stem-community", legacy: false},
    {slug: "gain-accreditation-as-a-professional-development-leader", legacy: false},
    {slug: "support-other-teachers-and-earn-a-stem-community-participation-badge", legacy: false},
    {slug: "run-an-enrichment-activity-in-your-classroom", legacy: false},
    {slug: "support-other-teachers-and-earn-a-stem-community-participation-badge", legacy: false},
    {slug: "undertake-the-initial-assessment-of-your-school-using-computing-quality-framework", legacy: false},
    {slug: "work-with-your-local-computing-hub-to-develop-a-school-level-action-plan-for-professional-development", legacy: false},
    {slug: "lead-your-school-into-a-computing-cluster-and-develop-an-action-plan-with-a-cluster-advisor", legacy: false},
    {slug: "become-an-i-belong-champion-primary", legacy: false},

    # Legacy activities
    {slug: "run-an-after-school-code-club", legacy: true},
    {slug: "lead-a-session-at-a-regional-or-national-conference", legacy: true},
    {slug: "lead-a-cas-community-of-practice", legacy: true},
    {slug: "providing-additional-support", legacy: true},

    {slug: "run-or-support-a-code-club-in-your-school", legacy: true},
    {slug: "provide-feedback-on-our-curriculum-resources", legacy: true},
    {slug: "provide-feedback-on-a-cas-resource", legacy: true},
    {slug: "attend-a-cas-community-meeting-secondary", legacy: true},
    {slug: "contribute-to-online-discussion-secondary", legacy: true},
    {slug: "complete-a-cs-accelerator-course", legacy: true},

    {slug: "provide-computing-cpd-in-your-school-or-to-another-local-school", legacy: true},
    {slug: "become-a-mentor", legacy: true},
    {slug: "give-additional-support-to-your-community", legacy: true},
    {slug: "join-gender-balance-in-computing-programme", legacy: true},
    {slug: "answer-5-questions-on-isaac-computer-science", legacy: true},
    {slug: "engage-with-stem-ambassadors", legacy: true},
    {slug: "run-a-code-club-or-coder-dojo", legacy: true},
    {slug: "answer-5-questions-on-isaac-computer-science", legacy: true},
    {slug: "join-and-present-at-your-local-computing-at-school-community", legacy: true}
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity[:slug], index + 1, legacy: activity[:legacy])
  end
end.save!
