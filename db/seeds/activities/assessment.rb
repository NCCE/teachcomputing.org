cs_accelerator = Programme.cs_accelerator

a = Activity.find_or_create_by(slug: 'cs-accelerator-assessment') do |activity|
  activity.title = 'CS Accelerator Assessment'
  activity.credit = 30
  activity.slug = activity.title.parameterize
  activity.category = 'assessment'
  activity.provider = 'classmarker'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

assessment = Assessment.find_or_create_by(programme_id: cs_accelerator.id) do |assessment|
  assessment.programme_id = cs_accelerator.id
  assessment.activity_id = a.id
  assessment.link = 'https://www.classmarker.com/online-test/start/?quiz=7jq5caf0e6ab8da3'
  assessment.class_marker_test_id = '1071279'
end

puts "Created assessment: #{assessment.activity.title} (#{assessment})"
