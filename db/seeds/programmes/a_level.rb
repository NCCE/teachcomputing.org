Programmes::ALevel.where(slug: "a-level").update(slug: "a-level-certificate")

a_level = Programmes::ALevel.find_or_initialize_by(slug: "a-level-certificate").tap do |programme|
  programme.title = "A level Computer Science subject knowledge"
  programme.slug = "a-level-certificate"
  programme.description = "A level subject Computer Science knowledege"
  programme.enrollable = true

  programme.save
end

puts "Created Programme: #{a_level.title} (#{a_level})"

ProgrammeCompleteCounter.find_or_create_by(programme_id: a_level.id) do |programme_complete_counter|
  programme_complete_counter.programme_id = a_level.id
  programme_complete_counter.counter = 0
end

Assessment.find_or_initialize_by(programme: a_level) do |assessment|
  assessment.link = "https://www.classmarker.com/online-test/start/?quiz=ax765118814b3236"
  assessment.class_marker_test_id = "2130199"
  assessment.programme = a_level
  assessment.required_pass_percentage = 65.0
end.save!
