Activity.find_or_create_by(slug: 'cs-accelerator-diagnostic-tool') do |activity|
    activity.title = 'Taken diagnostic tool'
    activity.credit = 10
    activity.slug = 'cs-accelerator-diagnostic-tool'
    activity.category = 'diagnostic'
    activity.self_certifiable = true
    activity.provider = 'system'
  end

  Activity.find_or_create_by(slug: 'primary-certificate-diagnostic') do |activity|
    activity.title = 'Completed the diagnostic tool'
    activity.credit = 10
    activity.slug = 'primary-certificate-diagnostic'
    activity.category = 'diagnostic'
    activity.self_certifiable = false
    activity.provider = 'system'
  end