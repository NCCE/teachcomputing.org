secondary = Programme.find_or_create_by(slug: 'secondary-certificate') do |programme|
  programme.title = 'Teach secondary computing'
  programme.slug = 'secondary-certificate'
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
  unless activity.programmes.include?(secondary)
    puts "Adding: #{activity.title} to #{secondary.slug}"
    activity.programmes << secondary
  end
end
