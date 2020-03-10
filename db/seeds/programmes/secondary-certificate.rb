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
  an-introduction-to-computer-networking-for-teachers
  how-computers-work-demystifying-computation
  introduction-to-cybersecurity-for-teachers
  impact-of-technology-how-to-lead-classroom-discussions
  object-oriented-programming-in-python-create-your-own-adventure-game
  programming-102-think-like-a-computer-scientist
  programming-with-guis
  representing-data-with-images-and-sound-bringing-data-to-life
  understanding-computer-systems
  understanding-maths-and-logic-in-computer-science
  algorithms-in-gcse-computer-science
  data-and-computer-systems-in-gcse-computer-science
  networks-and-cyber-security-in-gcse-computer-science
  python-programming-essentials-for-gcse-computer-science
  teaching-physical-computing-with-raspberry-pi-and-python
  gcse-computer-science-developing-outstanding-teaching
  programming-103-saving-and-structuring-data
  introduction-to-encryption-and-cryptography
  introduction-to-web-development
  networking-with-python-socket-programming-for-communication
  design-and-prototype-embedded-computer-systems
  introduction-to-gcse-computer-science
  programming-101-an-introduction-to-python-for-educators
  creating-an-inclusive-classroom-approaches-to-supporting-learners-with-send-in-computing
]

slugs.each do |slug|
  activity = Activity.find_by(slug: slug)
  unless activity.programmes.include?(secondary)
    puts "Adding: #{activity.title} to #{secondary.slug}"
    activity.programmes << secondary
  end
end
