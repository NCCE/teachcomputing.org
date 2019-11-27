primary = Programmes::PrimaryCertificate.find_or_create_by(slug: 'primary-certificate') do |programme|
  programme.title = 'Teach primary computing'
  programme.slug = 'primary-certificate'
  programme.description = 'Teach primary computing'
  programme.enrollable = false
end

puts "Created Programme: #{primary.title} (#{primary})"

programme_complete_counter = ProgrammeCompleteCounter.find_or_create_by(programme_id: primary.id) do |programme_complete_counter|
  programme_complete_counter.programme_id = primary.id
  programme_complete_counter.counter = 0
end

puts "Created programme_complete_counter: #{programme_complete_counter}"

slugs = %w[
  primary-certificate-diagnostic
  registered-with-the-national-centre
  teaching-and-leading-key-stage-1-computing
  teaching-and-leading-key-stage-2-computing
  primary-programming-and-algorithms
  programming-pedagogy-in-primary-schools-developing-computing-teaching
  creating-an-inclusive-classroom-approaches-to-supporting-learners-with-send-in-computing
  teaching-programming-in-primary-schools
  primary-programming-and-algorithms
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
