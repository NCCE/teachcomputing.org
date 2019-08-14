primary = Programme.find_or_create_by(slug: 'primary-certificate') do |programme|
  programme.title = 'Teach primary computing'
  programme.slug = 'primary-certificate'
  programme.description = 'Teach primary computing'
  programme.enrollable = false
end

puts "Created Programme: #{primary.title} (#{primary})"

slugs = %w[
  registered-with-the-national-centre
  teaching-and-leading-key-stage-1-computing
  teaching-and-leading-key-stage-2-computing
  primary-programming-and-algorithms
  teaching-programming-in-primary-schools
  scratch-to-python-moving-from-block-to-text-based-programming
]

slugs.each do |slug|
  activity = Activity.find_by(slug: slug)
  unless activity.programmes.include?(primary)
    puts "Adding: #{activity.title} to #{primary.slug}"
    activity.programmes << primary
  end
end
