i_belong = Programmes::IBelongCertificate.find_or_create_by(slug: 'i-belong-certificate') do |programme|
  programme.title = 'I Belong'
  programme.slug = 'i-belong-certificate'
  programme.description = 'I Belong: encouraging girls into computer science'
  programme.enrollable = true
end

puts "Created Programme: #{secondary.title} (#{secondary})"

ProgrammeCompleteCounter.find_or_create_by(programme_id: i_belong.id) do |programme_complete_counter|
  programme_complete_counter.programme_id = secondary.id
  programme_complete_counter.counter = 0
end
