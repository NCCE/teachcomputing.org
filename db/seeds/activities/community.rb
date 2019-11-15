Activity.find_or_create_by(slug: 'contribute-to-online-discussion') do |activity|
  activity.title = 'Contribute to online discussion'
  activity.credit = 5
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.description = 'This is CAS online discussion forums and could include the CAS forum, #CASChat, webinars and other NCCE activities.'
  activity.self_verification_info = 'Please provide a link to your contribution'
end

Activity.find_or_create_by(slug: 'attend-a-cas-community-meeting') do |activity|
  activity.title = 'Attend a CAS Community meeting'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.description = 'Some words about what this activity involves. And a link to point the teacher towards to take action on it: <a href="#">find a CAS community meeting</a>.'
  activity.self_verification_info = 'Please provide the date and venue details of the meeting'
end

Activity.find_or_create_by(slug: 'review-a-resource-on-cas') do |activity|
  activity.title = 'Review a resource on CAS'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide a link to your contribution'
end

Activity.find_or_create_by(slug: 'host-or-attend-a-barefoot-workshop') do |activity|
  activity.title = 'Host or attend a Barefoot Workshop'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'barefoot'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with the date and location of the workshop'
end

Activity.find_or_create_by(slug: 'lead-a-cas-community-of-practice') do |activity|
  activity.title = 'Lead a CAS Community of Practice'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide us with the name and postcode of the CAS community you're leading"
end

Activity.find_or_create_by(slug: 'run-an-after-school-code-club') do |activity|
  activity.title = 'Run an after-school Code Club'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'code-club'
  activity.self_certifiable = true
  activity.description = 'This is CAS online discussion forums and could include the CAS forum, #CASChat, webinars and other NCCE activities.'
  activity.self_verification_info = 'Please provide us with the name and postcode of your Code Club'
end

Activity.find_or_create_by(slug: 'lead-a-session-at-a-regional-or-national-conference') do |activity|
  activity.title = 'Lead a session at a regional or national conference'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with a link conference programme'
end
