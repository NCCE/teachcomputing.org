cs_accelerator = Programme.cs_accelerator

Activity.find_by(slug: 'cs-accelerator-diagnostic-tool')&.update(slug: 'subject-knowledge-diagnostic-tool')

a = Activity.find_or_create_by(slug: 'subject-knowledge-diagnostic-tool') do |activity|
  activity.title = 'Taken diagnostic tool'
  activity.credit = 10
  activity.slug = 'subject-knowledge-diagnostic-tool'
  activity.category = 'diagnostic'
  activity.self_certifiable = true
  activity.provider = 'system'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)
