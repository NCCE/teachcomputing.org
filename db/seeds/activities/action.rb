Activity.find_or_create_by(slug: 'diagnostic-tool') do |activity|
  activity.title = 'Used the diagnostic tool'
  activity.credit = 10
  activity.slug = 'diagnostic-tool'
  activity.category = 'action'
  activity.self_certifiable = true
  activity.provider = 'system'
end

Activity.find_or_create_by(slug: 'registered-with-the-national-centre') do |activity|
  activity.title = 'Created your account with the National Centre for Computing Education'
  activity.credit = 5
  activity.slug = 'registered-with-the-national-centre'
  activity.category = 'action'
  activity.self_certifiable = false
  activity.provider = 'system'
end

Activity.find_or_create_by(slug: 'ncce-coaching-and-mentoring') do |activity|
  activity.title = 'NCCE - Coaching and Mentoring'
  activity.credit = 0
  activity.slug = 'ncce-coaching-and-mentoring'
  activity.stem_course_id = 'eb7c08ea-212a-4d27-8bde-a629f36192f6'
  activity.category = 'action'
  activity.provider = 'stem-learning'
end
