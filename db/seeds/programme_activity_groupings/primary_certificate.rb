primary_certificate = Programme.primary_certificate

puts 'Creating Programme Activity Groupings for Primary certificate'

## The numbering of the groupings starts at 2 for historical reasons: group_one with sort_key 1 existed when users were required
## to complete 2 courses, one from each of groups 1 and 2.

primary_certificate.programme_activity_groupings.find_or_initialize_by(title: 'All courses').becomes!(ProgrammeActivityGroupings::CreditCounted).tap do |group|
  group.sort_key = 2
  group.required_for_completion = 1
  group.programme_id = primary_certificate.id
  group.progress_bar_title = 'Complete professional development'
  group.web_copy_course_requirements = 'Complete one full day face-to-face, remote or online course, or a combination of short courses that amounts to 6+ hours of professional development.'
  group.required_credit_count = 50

  group.save

  primary_certificate.activities.courses.each do |activity|
    programme_activity = primary_certificate.programme_activities.find_or_create_by(activity_id: activity.id)
    programme_activity.update(programme_activity_grouping_id: group.id) unless group.programme_activities.include?(programme_activity)
  end
end.save

ProgrammeActivityGrouping.find_by(title: 'Contribute to an online discussion')&.destroy

primary_certificate.programme_activity_groupings.find_or_initialize_by(title: 'Develop your teaching practice').tap do |group|
  group.sort_key = 3
  group.required_for_completion = 1
  group.programme_id = primary_certificate.id
  group.community = true
  group.progress_bar_title = 'Develop your teaching practice'
  group.web_copy_course_requirements = 'Choose at least one activity'

  group.save

  activities = [
    'review-a-resource-on-cas',
    'host-or-attend-a-barefoot-workshop',
    'raise-aspirations-with-a-stem-ambassador-visit',
    'attend-a-cas-community-meeting',
    'participate-fully-in-an-ncce-curriculum-enrichment-oppertunity',
    'implement-your-professional-development-in-the-classroom-and-evaluate-via-the-impact-toolkit',
    'download-and-use-the-ncce-teaching-and-assessment-resources-in-your-classroom'
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity, index + 1)
  end
end.save

primary_certificate.programme_activity_groupings.find_or_initialize_by(title: 'Develop computing in your community').tap do |group|
  group.sort_key = 4
  group.required_for_completion = 1
  group.programme_id = primary_certificate.id
  group.community = true
  group.progress_bar_title = 'Develop computing in your community'
  group.web_copy_course_requirements = 'Choose at least one activity'

  group.save

  activities = [
    'run-an-after-school-code-club',
    'lead-a-session-at-a-regional-or-national-conference',
    'lead-a-cas-community-of-practice',
    'providing-additional-support',
    'share-tips-on-using-an-ncce-resource-in-your-classroom-with-colleagues-on-stem-community',
    'gain-accreditation-as-a-professional-development-leader',
    'support-other-teachers-and-earn-a-stem-community-participation-badge',
    'run-or-support-a-code-club-in-your-school',
    'run-an-enrichment-activity-in-your-classroom',
    'support-other-teachers-and-earn-a-stem-community-participation-badge',
    'undertake-the-initial-assessment-of-your-school-using-computing-quality-framework',
    'work-with-your-local-computing-hub-to-develop-a-school-level-action-plan-for-professional-development',
    'lead-your-school-into-a-computing-cluster-and-develop-an-action-plan-with-a-cluster-advisor',
    'join-and-present-at-your-local-computing-at-school-community'
  ]


  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity, index + 1)
  end
end.save
