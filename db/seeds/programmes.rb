cs_accelerator = Programme.find_or_create_by(slug: 'cs-accelerator') do |programme|
  programme.title = 'GCSE computer science subject knowledge'
  programme.slug = 'cs-accelerator'
  programme.description = 'If you’re a secondary school teacher without a post A level qualification in computer science or a related subject then the Computer Science Accelerator Programme is specifically designed to help you.'
end

puts "Created Programme: #{cs_accelerator.title} (#{cs_accelerator})"

activity = Activity.find_by(slug: 'cs-accelerator-assessment')

assessment = Assessment.find_or_create_by(programme_id: cs_accelerator.id) do |assessment|
  assessment.programme_id = cs_accelerator.id
  assessment.activity_id = activity.id
  assessment.link = 'https://www.classmarker.com/online-test/start/?quiz=7jq5caf0e6ab8da3'
  assessment.class_marker_test_id = '1071279'
end

puts "Created assessment: #{assessment.activity.title} (#{assessment})"

assessment_counter = AssessmentCounter.find_or_create_by(assessment_id: assessment.id) do |assessment_counter|
  assessment_counter.assessment_id = assessment.id
  assessment_counter.counter = 0
end

puts "Created assessment_counter: #{assessment_counter}"

slugs = %w[
  registered-with-the-national-centre
  diagnostic-tool
  algorithms-in-gcse-computer-science
  data-and-computer-systems-in-gcse-computer-science
  networks-and-cyber-security-in-gcse-computer-science
  python-programming-essentials-for-gcse-computer-science
  teaching-physical-computing-with-raspberry-pi-and-python
  how-computers-work-demystifying-computation
  programming-101-an-introduction-to-python-for-educators
  programming-102-think-like-a-computer-scientist
  representing-data-with-images-and-sound-bringing-data-to-life
  object-oriented-programming-in-python-create-your-own-adventure-game
  an-introduction-to-computer-networking-for-teachers
  understanding-maths-and-logic-in-computer-science
  understanding-computer-systems
  cs-accelerator-assessment
  introduction-to-cybersecurity-for-teachers
]

slugs.each do |slug|
  activity = Activity.find_by(slug: slug)
  unless activity.programmes.include?(cs_accelerator)
    puts "Adding: #{activity.title} to #{cs_accelerator.slug}"
    activity.programmes << cs_accelerator
  end
end
