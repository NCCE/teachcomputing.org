Programmes::CSAccelerator.find_by(slug: "cs-accelerator")&.update(slug: "subject-knowledge")

cs_accelerator = Programmes::CSAccelerator.find_or_initialize_by(slug: "subject-knowledge").tap do |programme|
  programme.title = "Key stage 3 and GCSE Computer Science certificate"
  programme.slug = "subject-knowledge"
  programme.description = "If you're a secondary school teacher without a post A level qualification in computer science or a related subject then the Computer Science Accelerator Programme is specifically designed to help you."
  programme.enrollable = true
  programme.dashboard_name = "Key Stage 3 and GCSE subject knowledge"
  programme.save!
end

puts "Created Programme: #{cs_accelerator.title} (#{cs_accelerator})"

programme_complete_counter = ProgrammeCompleteCounter.find_or_create_by(programme_id: cs_accelerator.id) do |programme_complete_counter|
  programme_complete_counter.programme_id = cs_accelerator.id
  programme_complete_counter.counter = 0
end

puts "Created programme_complete_counter: #{programme_complete_counter}"

Programmes::CSAccelerator.find_by(slug: "cs-accelerator-enrolment-questionnaire")&.update(slug: "subject-knowledge-enrolment-questionnaire")
questionnaire = Questionnaire.find_or_create_by(slug: "subject-knowledge-enrolment-questionnaire") do |q|
  q.title = "Enrolment questionnaire"
  q.slug = "subject-knowledge-enrolment-questionnaire"
  q.description = "Questionnaire description"
  q.programme = cs_accelerator
end

puts "Created CSAccelerator enrolment questionnaire: #{questionnaire}"
