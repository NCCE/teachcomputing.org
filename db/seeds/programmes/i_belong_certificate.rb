Programmes::IBelongCertificate.find_or_initialize_by(slug: 'i-belong-certificate').tap do |programme|
  programme.title = 'I Belong: encouraging girls into computer science'
  programme.slug = 'i-belong-certificate'
  programme.description = 'Encouraging girls into computer science'
  programme.enrollable = true

  programme.save
end

puts "Created Programme: #{i_belong.title} (#{i_belong})"

ProgrammeCompleteCounter.find_or_create_by(programme_id: i_belong.id) do |programme_complete_counter|
  programme_complete_counter.programme_id = i_belong.id
  programme_complete_counter.counter = 0
end
