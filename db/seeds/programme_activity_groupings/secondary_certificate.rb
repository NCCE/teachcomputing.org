secondary = Programme.secondary_certificate

puts 'Creating Programme Activity Groupings'

## The numbering of the groupings starts at 2 for historical reasons: group_one with sort_key 1 existed when users were required
## to complete 2 courses, one from each of groups 1 and 2.

secondary.programme_activity_groupings.find_or_create_by(title: 'All courses') do |programme_activity_group|
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

secondary.programme_activity_groupings.find_or_initialize_by(title: 'Make a positive impact on young people in computing').tap do |group|
  group.title = 'Make a positive impact on young people in computing'
  group.sort_key = 6
  group.required_for_completion = 1
  group.programme_id = secondary.id
  group.community = true

  group.save

  activities = [
    'raise-aspirations-with-a-stem-ambassador-visit',
    'participate-fully-in-an-ncce-curriculum-enrichment-oppertunity',
    'implement-your-professional-development-in-the-classroom-and-evaluate-via-the-impact-toolkit',
    'download-and-use-the-ncce-teaching-and-assessment-resources-in-your-classroom',
    'join-the-ib-encouraging-girls-into-cs-programme-and-become-an-ibc'
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity, index + 1)
  end
end.save

secondary.programme_activity_groupings.find_or_initialize_by(title: 'Support your professional community').tap do |group|
  group.title = 'Support your professional community'
  group.sort_key = 7
  group.required_for_completion = 1
  group.programme_id = secondary.id
  group.community = true

  group.save

  activities = [
    'gain-accreditation-as-a-professional-development-leader',
    'support-other-teachers-and-earn-a-stem-community-participation-badge',
    'undertake-the-initial-assessment-of-your-school-using-computing-quality-framework',
    'gain-accreditation-as-an-i-belong-champion',
    'work-with-local-business-and-industry-to-inspire-inclusive-computing',
    'work-with-your-local-computing-hub-to-develop-a-school-level-action-plan-for-professional-development',
    'lead-your-school-into-a-computing-cluster-and-develop-an-action-plan-with-a-cluster-advisor',
    'join-and-present-at-your-local-computing-at-school-community'
  ]

  activities.each_with_index do |activity, index|
    maybe_attach_activity_to_grouping(group, activity, index + 1)
  end
end.save

puts 'Seeding Programme Activity Groupings for Secondary'

# Courses

group_two = secondary.programme_activity_groupings.find_by(sort_key: 2)

secondary.activities.courses.each do |activity|
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_two.id) unless group_two.programme_activities.include?(programme_activity)
end

# Community Achievements

group_three = secondary.programme_activity_groupings.find_by(sort_key: 3)

if activity = Activity.find_by(slug: 'provide-feedback-on-our-curriculum-resources')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id, order: 1) unless group_three.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'provide-feedback-on-a-cas-resource')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id, order: 2) unless group_three.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'complete-a-cs-accelerator-course')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id, order: 3) unless group_three.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'contribute-to-online-discussion-secondary')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_three.id, order: 4) unless group_three.programme_activities.include?(programme_activity)
end

group_four = secondary.programme_activity_groupings.find_by(sort_key: 4)

if activity = Activity.find_by(slug: 'engage-with-stem-ambassadors')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 1) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'answer-5-questions-on-isaac-computer-science')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 2) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'run-a-code-club-or-coder-dojo')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 3) unless group_four.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'join-gender-balance-in-computing-programme')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_four.id, order: 4) unless group_four.programme_activities.include?(programme_activity)
end

group_five = secondary.programme_activity_groupings.find_by(sort_key: 5)

if activity = Activity.find_by(slug: 'provide-computing-cpd-in-your-school-or-to-another-local-school')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 1) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'become-a-mentor')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 2) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'give-additional-support-to-your-community')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 3) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'lead-a-session-at-a-regional-or-national-conference-secondary')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 4) unless group_five.programme_activities.include?(programme_activity)
end

if activity = Activity.find_by(slug: 'lead-a-cas-community-of-practice-secondary')
  programme_activity = secondary.programme_activities.find_or_create_by(activity_id: activity.id)
  programme_activity.update(programme_activity_grouping_id: group_five.id, order: 5) unless group_five.programme_activities.include?(programme_activity)
end
