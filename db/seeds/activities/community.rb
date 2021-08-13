primary_certificate = Programme.primary_certificate
secondary_certificate = Programme.secondary_certificate

a = Activity.find_or_create_by(slug: 'contribute-to-online-discussion') do |activity|
  activity.title = 'Contribute to an online Computing at School (CAS) discussion'
  activity.credit = 5
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide a link to your contribution'
  activity.description = 'Engage in a CAS online discussion forum or webinar, and share best practice with other teachers. Provide a link to a screenshot or the forum discussion.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'contribute-to-online-discussion-secondary') do |activity|
  activity.title = 'Contribute to online discussion'
  activity.credit = 5
  activity.slug = 'contribute-to-online-discussion-secondary'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide a link to your contribution'
  activity.description = 'Engage in the CAS online discussion forums and webinars in a meaningful way.'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'attend-a-cas-community-meeting') do |activity|
  activity.title = 'Attend a CAS Community meeting'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide the date and venue details of the meeting'
  activity.description = 'Join <a href="https://community.computingatschool.org.uk/communities" data-event-label="CAS meeting" class="ncce-link">your local CAS Community </a>and attend a session. You’ll meet other teachers in your area and get to share best practice. Provide the date and event details'
end
a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'attend-a-cas-community-meeting-secondary') do |activity|
  activity.title = 'Attend a CAS Community meeting'
  activity.credit = 10
  activity.slug = 'attend-a-cas-community-meeting-secondary'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide the date and venue details of the meeting'
  activity.description = 'Join <a href="https://community.computingatschool.org.uk/communities" data-event-label="CAS meeting" class="ncce-link">your local CAS Community </a>and attend a session. You’ll meet other teachers in your area and get to share best practice. Provide the date and event details'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'review-a-resource-on-cas') do |activity|
  activity.title = 'Provide feedback on a teaching resource'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide a link to your contribution'
  activity.description = 'Download a <a href="https://teachcomputing.org/curriculum/key-stage-1" data-event-label="CAS forum" class="ncce-link">KS1 lesson<a/> or <a href="https://teachcomputing.org/curriculum/key-stage-2" data-event-label="CAS forum" class="ncce-link">KS2 lesson</a> from Teach Computing Curriculum resources, or <a href="https://community.computingatschool.org.uk/resources/2616/single" data-event-label="CAS forum" class="ncce-link">a CAS teaching resource</a> and use it in your classroom. Reflect and share your feedback on how you used and adapted it.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'provide-feedback-on-a-cas-resource') do |activity|
  activity.title = 'Provide feedback on a CAS resource'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide a link to your contribution'
  activity.description = 'Give a full review of a <a href="https://community.computingatschool.org.uk/resources/landing" class="ncce-link" class="ncce-link">CAS resource you’ve downloaded</a> - including how you used it in the classroom'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'host-or-attend-a-barefoot-workshop') do |activity|
  activity.title = 'Organise a Barefoot Workshop at your school'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'barefoot'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with the date and location of the workshop'
  activity.description = ' Reach out to <a href="https://www.barefootcomputing.org/primary-computing-workshops" data-event-label="Barefoot workshop" class="ncce-link">Barefoot volunteers</a> and get them to present a workshop in your school. Provide the date and location the workshop took place.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'lead-a-cas-community-of-practice') do |activity|
  activity.title = 'Lead a CAS Community of Practice'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide us with the name and postcode of the CAS community you're leading"
  activity.description = 'Register as <a href="https://community.computingatschool.org.uk/hubs" data-event-label="CAS leader" class="ncce-link">a CAS Community Leader</a> and run 3 meetings per year. Low maintenance and high impact, it should only take 1 to 2 hrs per month to organise each meeting. Provide the name and location of your community.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'lead-a-cas-community-of-practice-secondary') do |activity|
  activity.title = 'Lead a CAS Community of Practice'
  activity.credit = 20
  activity.slug = 'lead-a-cas-community-of-practice-secondary'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide us with the name and postcode of the CAS community you're leading"
  activity.description = 'Register as <a href="https://community.computingatschool.org.uk/hubs" data-event-label="CAS leader" class="ncce-link">a CAS Community Leader</a> and run 3 meetings per year. Low maintenance and high impact, it should only take 1 to 2 hrs per month to organise each meeting. Provide the name and location of your community.'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'providing-additional-support') do |activity|
  activity.title = 'Give additional support to your community'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please give details of the additional support you have provided'
  activity.description = 'Go beyond your day to day teaching, and support your local teachers, pupils or parents. For example: mentoring another teacher in computing, helping parents to set up and use virtual classroom technology. Provide details of the support.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'run-an-after-school-code-club') do |activity|
  activity.title = 'Set up and run a Code Club in your school'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'raspberrypi'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with the name and postcode of your Code Club'
  activity.description = '<a href="https://codeclub.org/en/start-a-code-club" data-event-label="Start Code Club" class="ncce-link">Start a Code Club today</a> - free projects, resources and support for you to use with children aged 9 to 13. Already got a club at your school? Become a volunteer and help run it. Provide the name and postcode of your club.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'lead-a-session-at-a-regional-or-national-conference') do |activity|
  activity.title = 'Lead a session at a regional or national conference'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with a link conference programme'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'lead-a-session-at-a-regional-or-national-conference-secondary') do |activity|
  activity.title = 'Lead a session at a regional or national conference'
  activity.credit = 20
  activity.slug = 'lead-a-session-at-a-regional-or-national-conference-secondary'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with a link conference programme'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'provide-feedback-on-our-curriculum-resources') do |activity|
  activity.title = 'Provide feedback on our curriculum resources'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Give a full review of <a href="https://teachcomputing.org/curriculum" class="ncce-link">a Teach Computing curriculum lesson you’ve downloaded</a> - including how you used it in the classroom.'
  activity.self_verification_info = 'Provide screenshot of feedback'
  activity.uploadable = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'provide-computing-cpd-in-your-school-or-to-another-local-school') do |activity|
  activity.title = 'Provide computing CPD in your school or to another local school'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Deliver computing CPD in your school, or another local school'
  activity.self_verification_info = 'Provide details of the training including date training took place'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'become-a-mentor') do |activity|
  activity.title = 'Become a mentor'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Support another teacher through the CS Accelerator programme, or support a trainee teacher in qualifying as a computing teacher'
  activity.self_verification_info = 'Provide details of who/how you provided support'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'give-additional-support-to-your-community') do |activity|
  activity.title = 'Give additional support to your community'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Go beyond your day to day teaching, and support your local teachers, pupils or parents'
  activity.self_verification_info = 'Provide details of support provided'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'join-gender-balance-in-computing-programme') do |activity|
  activity.title = 'Join Gender Balance in Computing Programme'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Support gender equality in computing, by participating in our research programme. <a href="https://teachcomputing.org/gender-balance" class="ncce-link">Find out more and register</a>.'
  activity.self_verification_info = 'Screenshot to show registration'
  activity.uploadable = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'answer-5-questions-on-isaac-computer-science') do |activity|
  activity.title = 'Answer 5 questions on Isaac Computer Science'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'isaac'
  activity.self_certifiable = true
  activity.description = "<a href='https://isaaccomputerscience.org/teachers' class='ncce-link'>Log in or register for Isaac Computer Science</a> and <a href='https://isaaccomputerscience.org/topics' class='ncce=link'>answer any 5 questions from across the topic sections. <a href='https://isaaccomputerscience.org/progress' class='ncce-link'>Screenshot your progress dashboard</a> as evidence you have completed this activity."
  activity.self_verification_info = 'Provide screenshot of your progress dashboard'
  activity.uploadable = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'engage-with-stem-ambassadors') do |activity|
  activity.title = 'Engage with STEM Ambassadors'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'stem-learning'
  activity.self_certifiable = true
  activity.description = '<a href="https://www.stem.org.uk/stem-ambassadors/inspiration/activities" class="ncce=link">Register for STEM ambassadors</a> and complete a visit, or any other meaningful engagement'
  activity.self_verification_info = ''
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'run-a-code-club-or-coder-dojo') do |activity|
  activity.title = 'Run a Code Club or Coder Dojo'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'raspberrypi'
  activity.self_certifiable = true
  activity.description = 'Run an after-school <a href="https://codeclub.org/en/start-a-code-club" class="ncce-link">Code Club</a> or <a href="https://coderdojo.com/start-a-dojo/" class="ncce-link">Coder Dojo</a>, and help young people to learn to code.'
  activity.self_verification_info = 'Provide address including postcode'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'complete-a-cs-accelerator-course') do |activity|
  activity.title = 'Complete a CS Accelerator course'
  activity.credit = 10
  activity.slug = 'complete-a-cs-accelerator-course'
  activity.stem_course_template_no = ''
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.description = 'Complete an additional <a href="https://teachcomputing.org/courses?certificate=cs-accelerator" class="ncce-link">CS Accelerator course</a> and expand your subject knowledge'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)
