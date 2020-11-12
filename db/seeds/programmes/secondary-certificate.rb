secondary = Programmes::SecondaryCertificate.find_or_create_by(slug: 'secondary-certificate') do |programme|
  programme.title = 'Teach secondary computing'
  programme.slug = 'secondary-certificate'
  programme.description = 'Teach secondary computing'
  programme.enrollable = false
end

puts "Created Programme: #{secondary.title} (#{secondary})"

programme_complete_counter = ProgrammeCompleteCounter.find_or_create_by(programme_id: secondary.id) do |programme_complete_counter|
  programme_complete_counter.programme_id = secondary.id
  programme_complete_counter.counter = 0
end

puts 'Creating Programme Activity Groupings' do
  secondary.programme_activity_group.find_or_create_by(title: 'Course requirements') do |programme_activity_group|
    programme_activity_group.sort_key 1
    programme_activity_group.required_for_completion = 2
    programme_activity_group.programme_id = secondary.id
  end

  secondary.programme_activity_group.find_or_create_by(title: 'Develop yourself') do |programme_activity_group|
    programme_activity_group.sort_key 2
    programme_activity_group.required_for_completion = 1
    programme_activity_group.programme_id = secondary.id
  end

  secondary.programme_activity_group.find_or_create_by(title: 'Develop your professional community') do |programme_activity_group|
    programme_activity_group.sort_key 3
    programme_activity_group.required_for_completion = 1
    programme_activity_group.programme_id = secondary.id
  end

  secondary.programme_activity_group.find_or_create_by(title: 'Develop your students') do |programme_activity_group|
    programme_activity_group.sort_key 4
    programme_activity_group.required_for_completion = 1
    programme_activity_group.programme_id = secondary.id
  end
end
