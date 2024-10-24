secondary = Programmes::SecondaryCertificate.find_or_create_by(slug: "secondary-certificate").tap do |programme|
  programme.title = "Teach secondary computing"
  programme.slug = "secondary-certificate"
  programme.description = "Teach secondary computing"
  programme.enrollable = true
  programme.dashboard_name = "Teach secondary computing"
  programme.save!
end

puts "Created Programme: #{secondary.title} (#{secondary})"

ProgrammeCompleteCounter.find_or_create_by(programme_id: secondary.id) do |programme_complete_counter|
  programme_complete_counter.programme_id = secondary.id
  programme_complete_counter.counter = 0
end
