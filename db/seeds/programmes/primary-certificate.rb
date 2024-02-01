primary = Programmes::PrimaryCertificate.find_or_initialize_by(slug: "primary-certificate").tap do |programme|
  programme.title = "Teach primary computing"
  programme.slug = "primary-certificate"
  programme.description = "Teach primary computing"
  programme.enrollable = true
  programme.save!
end

puts "Created Programme: #{primary.title} (#{primary})"

programme_complete_counter = ProgrammeCompleteCounter.find_or_create_by(programme_id: primary.id) do |programme_complete_counter|
  programme_complete_counter.programme_id = primary.id
  programme_complete_counter.counter = 0
end

puts "Created programme_complete_counter: #{programme_complete_counter}"

questionnaire = Questionnaire.find_or_create_by(slug: "primary-certificate-enrolment-questionnaire") do |q|
  q.title = "Enrolment questionnaire"
  q.slug = "primary-certificate-enrolment-questionnaire"
  q.description = "This questionnaire is designed to give you some ideas of how to start your learning journey with the NCCE and give you direction towards the courses that might be of most use to you."
  q.programme = primary
end

puts "Created primary enrolment questionnaire: #{questionnaire}"
