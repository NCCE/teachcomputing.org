cs_accelerator = Programmes::CSAccelerator.find_or_create_by(slug: 'cs-accelerator') do |programme|
  programme.title = 'Teach GCSE computer science'
  programme.slug = 'cs-accelerator'
  programme.description = 'If you’re a secondary school teacher without a post A level qualification in computer science or a related subject then the Computer Science Accelerator Programme is specifically designed to help you.'
  programme.enrollable = true
end

puts "Created Programme: #{cs_accelerator.title} (#{cs_accelerator})"

programme_complete_counter = ProgrammeCompleteCounter.find_or_create_by(programme_id: cs_accelerator.id) do |programme_complete_counter|
  programme_complete_counter.programme_id = cs_accelerator.id
  programme_complete_counter.counter = 0
end

puts "Created programme_complete_counter: #{programme_complete_counter}"
