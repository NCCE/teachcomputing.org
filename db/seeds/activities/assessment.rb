Activity.find_or_create_by(slug: 'cs-accelerator-assessment') do |activity|
  activity.title = 'CS Accelerator Assessment'
  activity.credit = 30
  activity.slug = activity.title.parameterize
  activity.category = 'assessment'
  activity.provider = 'classmarker'
end
