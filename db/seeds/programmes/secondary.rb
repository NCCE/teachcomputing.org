secondary = Programme.find_or_create_by(slug: 'secondary') do |programme|
  programme.title = 'Teach secondary computing'
  programme.slug = 'secondary'
  programme.description = 'Teach secondary computing'
  programme.enrollable = false
end

puts "Created Programme: #{secondary.title} (#{secondary})"

slugs = %w[
  registered-with-the-national-centre
  gcse-computer-science-developing-outstanding-teaching
  creative-computing-for-key-stage-3
  ks4-computing-for-all
  scratch-to-python-moving-from-block-to-text-based-programming
]

slugs.each do |slug|
  activity = Activity.find_by(slug: slug)
  unless activity.programmes.include?(secondary)
    puts "Adding: #{activity.title} to #{secondary.slug}"
    activity.programmes << secondary
  end
end
