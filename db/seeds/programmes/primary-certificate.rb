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
  contribute-to-online-discussion
  attend-a-cas-community-meeting
  review-a-resource-on-cas
  host-or-attend-a-barefoot-workshop
  lead-a-cas-community-of-practice
  run-an-after-school-code-club
  lead-a-session-at-a-regional-or-national-conference
]

slugs.each do |slug|
  activity = Activity.find_by(slug: slug)
  puts "Activity for slug #{slug} - #{activity}"
  unless activity.programmes.include?(primary)
    puts "Adding: #{activity.title} to #{primary.slug}"
    activity.programmes << primary
  end
end
