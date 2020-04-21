primary = Programmes::PrimaryCertificate.find_or_create_by(slug: 'primary-certificate') do |programme|
  programme.title = 'Teach primary computing'
  programme.slug = 'primary-certificate'
  programme.description = 'Teach primary computing'
  programme.enrollable = true
end

puts "Created Programme: #{primary.title} (#{primary})"

programme_complete_counter = ProgrammeCompleteCounter.find_or_create_by(programme_id: primary.id) do |programme_complete_counter|
  programme_complete_counter.programme_id = primary.id
  programme_complete_counter.counter = 0
end

puts "Created programme_complete_counter: #{programme_complete_counter}"

questionnaire = Questionnaire.find_or_create_by(slug: 'primary-certificate-enrolment-questionnaire') do |q|
  q.title = 'Enrolment questionnaire'
  q.slug = 'primary-certificate-enrolment-questionnaire'
  q.description = 'This questionnaire is designed to give you some ideas of how to start your learning journey with the NCCE and give you direction towards the courses that might be of most use to you.'
  q.programme = primary
end

puts "Created primary enrolment questionnaire: #{questionnaire}"

slugs = %w[
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
  programming-101-an-introduction-to-python-for-educators
  scratch-to-python-moving-from-block-to-text-based-programming
  teaching-and-leading-key-stage-1-computing-module-1
  teaching-and-leading-key-stage-1-computing-module-2
  teaching-and-leading-key-stage-2-computing-module-1
  teaching-and-leading-key-stage-2-computing-module-2
]

slugs.each do |slug|
  activity = Activity.find_by(slug: slug)
  puts "Activity for slug #{slug} - #{activity}"
  unless activity.programmes.include?(primary)
    puts "Adding: #{activity.title} to #{primary.slug}"
    activity.programmes << primary
  end
end
