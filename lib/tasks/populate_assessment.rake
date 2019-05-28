namespace :assessments do
  task cs_accelerator: :environment do
    programme = Programme.find_or_create_by(slug: 'cs-accelerator') do |programme|
      programme.title = 'GCSE computer science subject knowledge'
      programme.slug = 'cs-accelerator'
      programme.description = 'If you’re a secondary school teacher without a post A level qualification in computer science or a related subject then the Computer Science Accelerator Programme is specifically designed to help you.'
    end

    activity = Activity.find_or_create_by(slug: 'cs-accelerator-assessment') do |activity|
      activity.title = 'CS Accelerator Assessment'
      activity.credit = 30
      activity.slug = activity.title.parameterize
      activity.category = 'assessment'
      activity.provider = 'classmarker'
    end

    Assessment.find_or_create_by(programme_id: programme.id) do |assessment|
      assessment.programme_id = programme.id
      assessment.activity_id = activity.id
      assessment.link = 'https://google.com/placeholder'
      assessment.class_marker_test_id = 'test123'
    end
  end
end
