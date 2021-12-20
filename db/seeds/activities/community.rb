primary_certificate = Programme.primary_certificate
secondary_certificate = Programme.secondary_certificate

a = Activity.find_or_create_by(slug: 'contribute-to-online-discussion') do |activity|
  activity.title = 'Contribute to online discussion'
  activity.credit = 5
  activity.slug = 'contribute-to-online-discussion'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide a link to your contribution'
  activity.description = '<a href="https://community.computingatschool.org.uk/sign_up" data-event-label="Join CAS" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Join the Computing at School (CAS) community</a> to explore teaching ideas, resources and best practice with other teachers, engaging in <a href="https://community.computingatschool.org.uk/forums" data-event-label="Online CAS discussion" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">online discussion forums or webinars</a>. CAS is a grass-roots community of computing educators, offering free, informal sessions for teachers.'
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
  activity.title = 'Gain support and share ideas in a CAS Community meeting'
  activity.slug = 'attend-a-cas-community-meeting'
  activity.credit = 10
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide the date and venue details of the meeting'
  activity.description = 'By <a href="https://community.computingatschool.org.uk/communities" data-event-label="CAS meeting" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">joining and attending a session at your local Computing at School (CAS) Community</a>, you’ll meet other teachers in similar roles, sharing ideas, resources and insights. CAS is a grass-roots community of computing educators, offering free, informal sessions for teachers.'
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
  activity.title = 'Use and feedback on a teaching resource'
  activity.credit = 10
  activity.slug = 'review-a-resource-on-cas'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide a link to your contribution'
  activity.description = 'Download and use a <a href="/curriculum" data-event-label="Curriculum resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Teach Computing Curriculum resource</a>, then reflect on how you used and adapted it in the classroom. You can also use <a href="https://community.computingatschool.org.uk/resources/2616/single" data-event-label="CAS resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">CAS teaching resources</a> or <a href="https://www.stem.org.uk/primary-computing-resources" data-event-label="STEM resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">STEM primary computing resources</a>. Submit a link to your feedback - this can be a document or screenshot on a shared drive, or a direct link to your review.'
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
  activity.description = 'Give a full review of a <a href="https://community.computingatschool.org.uk/resources/landing" class="ncce-link">CAS resource you’ve downloaded</a> - including how you used it in the classroom'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'host-or-attend-a-barefoot-workshop') do |activity|
  activity.title = 'Boost the teaching of computing in your school with a free Barefoot Workshop'
  activity.credit = 10
  activity.slug = 'host-or-attend-a-barefoot-workshop'
  activity.category = 'community'
  activity.provider = 'barefoot'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with the date and location of the workshop'
  activity.description = '<a href="https://www.barefootcomputing.org/primary-computing-workshops" data-event-label="Barefoot workshop" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Attend a free Barefoot online workshop</a>, designed to boost your subject knowledge and confidence. Workshops are themed around Computational Thinking, Programming in Scratch or Early Years.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'lead-a-cas-community-of-practice') do |activity|
  activity.title = 'Run a CAS Community of Practice'
  activity.credit = 20
  activity.slug = 'lead-a-cas-community-of-practice'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide us with the name and postcode of the CAS community you're leading"
  activity.description = '<a href="https://community.computingatschool.org.uk/hubs" data-event-label="CAS leader" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Register as a CAS Community leader</a> and run 3 meetings per year. Low maintenance and high impact, it should only take 1 to 2 hours a month to organise each meeting. Provide the name and location of your community.'
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
  activity.title = 'Support computing in your wider community'
  activity.credit = 20
  activity.slug = 'providing-additional-support'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please give details of the additional support you have provided'
  activity.description = "There are lots of ways you can help improve computing education, such as helping parents set up and use virtual classrooms, working collaboratively with teachers in your school, or arranging a computing-themed event in your community. Let us know how you've gone the extra mile in computing."
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'run-an-after-school-code-club') do |activity|
  activity.title = 'Help children learn to code at a Code Club'
  activity.credit = 20
  activity.slug = 'run-an-after-school-code-club'
  activity.category = 'community'
  activity.provider = 'raspberrypi'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with the name and postcode of your Code Club'
  activity.description = "Code Club sessions use free step-by-step project guides to enrich young people's experience of programming. You don't need to be an experienced coder to <a href='https://codeclub.org/en/volunteer' data-event-label='Code Club volunteer' data-event-category='Primary enrolled' data-event-action='click' class='ncce-link'>volunteer</a>, and resources and support are on-hand to help you. If there isn't a club set up already at your school, <a href='https://codeclub.org/en/start-a-code-club' data-event-label=' Start a Code Club today' data-event-category='Primary enrolled' data-event-action='click' class='ncce-link'>it's easy to start one</a>."
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'lead-a-session-at-a-regional-or-national-conference') do |activity|
  activity.title = 'Lead a session at a regional or national conference'
  activity.credit = 20
  activity.slug = 'lead-a-session-at-a-regional-or-national-conference'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with a link conference programme'
  activity.description = 'Present a session at a conference, for example <a href="https://community.computingatschool.org.uk/events" data-event-label="CAS showcase" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">the annual CAS Virtual Showcase</a> or through <a href="/hubs" data-event-label="Hub showcase" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">your local Computing Hub</a>.'
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
  activity.description = "<a href='https://isaaccomputerscience.org/teachers' class='ncce-link'>Log in or register for Isaac Computer Science</a> and <a href='https://isaaccomputerscience.org/topics' class='ncce-link'>answer any 5 questions from across the topic sections. <a href='https://isaaccomputerscience.org/progress' class='ncce-link'>Screenshot your progress dashboard</a> as evidence you have completed this activity."
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
  activity.description = '<a href="https://www.stem.org.uk/stem-ambassadors/inspiration/activities" class="ncce-link">Register for STEM ambassadors</a> and complete a visit, or any other meaningful engagement'
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

a = Activity.find_or_create_by(slug: 'raise-aspirations-with-a-stem-ambassador-visit') do |activity|
  activity.title = 'Raise aspirations with a STEM Ambassador visit  '
  activity.credit = 10
  activity.slug = 'raise-aspirations-with-a-stem-ambassador-visit'
  activity.category = 'community'
  activity.provider = 'stem-learning'
  activity.self_certifiable = true
  activity.description = '<a href="https://www.stem.org.uk/stem-ambassadors/schools-and-colleges" class="ncce-link">Arrange a visit for your school</a> to help pupils understand real-world applications of computing, and raise their career aspirations through engaging activities. STEM Ambassadors are inspiring and relatable role models who volunteer to support schools.'
  activity.self_verification_info = ''
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)
