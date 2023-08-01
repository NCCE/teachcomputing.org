primary_certificate = Programme.primary_certificate
secondary_certificate = Programme.secondary_certificate
i_belong_certificate = Programme.i_belong_certificate

a = Activity.find_or_create_by(slug: 'contribute-to-online-discussion') do |activity|
  activity.title = 'Contribute to online discussion'
  activity.credit = 5
  activity.slug = 'contribute-to-online-discussion'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide a link to your contribution'
  activity.description = '<a href="https://www.computingatschool.org.uk/account/new-member-application" data-event-label="Join CAS" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Join the Computing at School (CAS) community</a> to explore teaching ideas, resources and best practice with other teachers, engaging in <a href="https://forum.computingatschool.org.uk" data-event-label="Online CAS discussion" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">online discussion forums or webinars</a>. CAS is a grass-roots community of computing educators, offering free, informal sessions for teachers.'
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
  activity.description = '<a href="https://www.computingatschool.org.uk/account/new-member-application" data-event-label="Join CAS" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">Join the Computing at School (CAS) community</a> to explore teaching ideas, resources and best practice with other teachers, engaging in <a href="https://forum.computingatschool.org.uk" data-event-label="Online CAS discussion" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">online discussion forums or webinars</a>. CAS is a grass-roots community of computing educators, offering free, informal sessions for teachers.'
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
  activity.description = 'By <a href="https://www.computingatschool.org.uk/about-cas-communities" data-event-label="CAS meeting" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">joining and attending a session at your local Computing at School (CAS) Community</a>, you’ll meet other teachers in similar roles, sharing ideas, resources and insights. CAS is a grass-roots community of computing educators, offering free, informal sessions for teachers.'
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
  activity.description = 'Download and use a <a href="/curriculum" data-event-label="Curriculum resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Teach Computing Curriculum resource</a>, then reflect on how you used and adapted it in the classroom. You can also use <a href="https://www.computingatschool.org.uk/teaching-resources" data-event-label="CAS resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">CAS teaching resources</a> or <a href="https://www.stem.org.uk/primary-computing-resources" data-event-label="STEM resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">STEM primary computing resources</a>. Submit a link to your feedback - this can be a document or screenshot on a shared drive, or a direct link to your review.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'provide-feedback-on-a-cas-resource') do |activity|
  activity.title = 'Use and feedback on a CAS or STEM Learning resource'
  activity.credit = 10
  activity.slug = 'provide-feedback-on-a-cas-resource'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.description = 'Download and use a <a href="https://www.computingatschool.org.uk/teaching-resources" data-event-label="CAS resource" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">CAS teaching resource</a>, or a <a href="https://www.stem.org.uk/secondary-alevel-computing" data-event-label="STEM resource" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">STEM Learning secondary computing resource</a>, then reflect on how you used and adapted it in the classroom. Submit a link to your feedback - this can be a document or screenshot on a shared drive, or a direct link to your review.'
  activity.self_verification_info = 'Please provide a link to your review'
  activity.uploadable = false
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'host-or-attend-a-barefoot-workshop') do |activity|
  activity.title = 'Boost the teaching of computing in your school with a free Barefoot Workshop'
  activity.credit = 10
  activity.slug = 'host-or-attend-a-barefoot-workshop'
  activity.category = 'community'
  activity.provider = 'barefoot'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with details of the workshop'
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
  activity.description = '<a href="https://www.computingatschool.org.uk/about-cas-communities/cas-community-leaders" data-event-label="CAS leader" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Register as a CAS Community leader</a> and run 3 meetings per year. Low maintenance and high impact, it should only take 1 to 2 hours a month to organise each meeting. Provide the name and location of your community.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'lead-a-cas-community-of-practice-secondary') do |activity|
  activity.title = 'Run a CAS Community of Practice'
  activity.credit = 20
  activity.slug = 'lead-a-cas-community-of-practice-secondary'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide us with the name and postcode of the CAS community you're leading"
  activity.description = '<a href="https://www.computingatschool.org.uk/about-cas-communities/cas-community-leaders" data-event-label="CAS leader" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">Register as a CAS Community leader</a> and run 3 meetings per year. Low maintenance and high impact, it should only take 1 to 2 hours a month to organise each meeting. Provide the name and location of your community.'
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
  activity.description = 'Present a session at a conference, for example <a href="https://www.computingatschool.org.uk/events" data-event-label="CAS showcase" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">the annual CAS Virtual Showcase</a> or through <a href="/hubs" data-event-label="Hub showcase" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">your local Computing Hub</a>.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(slug: 'lead-a-session-at-a-regional-or-national-conference-secondary') do |activity|
  activity.title = 'Lead a session at a regional or national conference'
  activity.credit = 20
  activity.slug = 'lead-a-session-at-a-regional-or-national-conference-secondary'
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.description = 'Present a session at a conference, for example <a href="https://www.computingatschool.org.uk/events" data-event-label="CAS showcase" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">the annual CAS Virtual Showcase</a> or through <a href="/hubs" data-event-label="Hub showcase" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">your local Computing Hub</a>.'
  activity.self_verification_info = 'Please provide us with a link conference programme'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'provide-feedback-on-our-curriculum-resources') do |activity|
  activity.title = 'Use and feedback on our curriculum resources'
  activity.credit = 10
  activity.slug = 'provide-feedback-on-our-curriculum-resources'
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Download and use a <a href="/curriculum" data-event-label="Curriculum resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Teach Computing Curriculum resource</a>, then reflect on how you used and adapted it in the classroom. Submit a link to your feedback - this can be a document or screenshot on a shared drive, or a direct link to your review.'
  activity.self_verification_info = 'Please provide a link to your review'
  activity.uploadable = false
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'provide-computing-cpd-in-your-school-or-to-another-local-school') do |activity|
  activity.title = 'Provide computing CPD in your school or to another local school'
  activity.credit = 10
  activity.slug = 'provide-computing-cpd-in-your-school-or-to-another-local-school'
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Deliver computing CPD in your school, or another local school. Provide details of the training including the date training took place.'
  activity.self_verification_info = 'Provide details of the training including date training took place'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'become-a-mentor') do |activity|
  activity.title = 'Become a mentor'
  activity.credit = 10
  activity.slug = 'become-a-mentor'
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Support another teacher through the CS Accelerator programme, or support a trainee teacher in qualifying as a computing teacher. Provide details of the role of the person you helped, and how you supported them.'
  activity.self_verification_info = 'Provide the role of the person you helped, and details of how you supported them.'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'give-additional-support-to-your-community') do |activity|
  activity.title = 'Support computing in your wider community'
  activity.credit = 10
  activity.slug = 'give-additional-support-to-your-community'
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = "There are lots of ways you can help improve computing education, such as helping parents set up and use virtual classrooms, working collaboratively with teachers in your school, or arranging a computing-themed event in your community. Let us know how you've gone the extra mile in computing."
  activity.self_verification_info = 'Please give details of the additional support you have provided'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'join-gender-balance-in-computing-programme') do |activity|
  activity.title = 'Gender Balance in Computing Programme (closed to new registrations)'
  activity.credit = 10
  activity.slug = 'join-gender-balance-in-computing-programme'
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'If you took part in our research to support gender balance in computing, then please provide a copy of the email that confirms you signed a Memorandum of Understanding as evidence of your participation.'
  activity.self_verification_info = 'Screenshot of Memorandum of Understanding email'
  activity.uploadable = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'answer-5-questions-on-isaac-computer-science') do |activity|
  activity.title = 'Answer 5 questions on Isaac Computer Science'
  activity.credit = 10
  activity.slug = 'answer-5-questions-on-isaac-computer-science'
  activity.category = 'community'
  activity.provider = 'isaac'
  activity.self_certifiable = true
  activity.description = "<a href='https://isaaccomputerscience.org/teachers' data-event-label='Register Isaac CS' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>Log in or register for Isaac Computer Science</a> and <a href='https://isaaccomputerscience.org/topics' data-event-label='Isaac CS topics' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>answer any 5 questions from across the topic sections</a>. Screenshot <a href='https://isaaccomputerscience.org/progress' data-event-label='Isaac CS dashboard' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>your progress dashboard</a> as evidence you have completed this activity."
  activity.self_verification_info = 'Provide screenshot of your progress dashboard'
  activity.uploadable = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'engage-with-stem-ambassadors') do |activity|
  activity.title = 'Raise aspirations with a STEM Ambassador visit'
  activity.credit = 10
  activity.slug = 'engage-with-stem-ambassadors'
  activity.category = 'community'
  activity.provider = 'stem-learning'
  activity.self_certifiable = true
  activity.description = '<a href="https://www.stem.org.uk/stem-ambassadors/schools-and-colleges" data-event-label="STEM Ambassadors" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">Arrange a visit for your school</a> to help pupils understand real-world applications of computing, and raise their career aspirations through engaging activities. STEM Ambassadors are inspiring and relatable role models who volunteer to support schools.'
  activity.self_verification_info = 'Please provide us with the date and location of the visit'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'run-a-code-club-or-coder-dojo') do |activity|
  activity.title = 'Help children learn to code at a Code Club'
  activity.credit = 10
  activity.slug = 'run-a-code-club-or-coder-dojo'
  activity.category = 'community'
  activity.provider = 'raspberrypi'
  activity.self_certifiable = true
  activity.description = "Code Club sessions use free step-by-step project guides to enrich young people's experience of programming. You don't need to be an experienced coder <a href='https://codeclub.org/en/volunteer' data-event-label='Code Club volunteer' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>to volunteer</a>, and resources and support are on-hand to help you. If there isn't a club set up already at your school, <a href='https://codeclub.org/en/start-a-code-club' data-event-label='Start a Code Club today' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>it's easy to start one.</a>"
  activity.self_verification_info = 'Please provide us with the name and postcode of your Code Club'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'complete-a-cs-accelerator-course') do |activity|
  activity.title = 'Complete an additional CS Accelerator course'
  activity.credit = 10
  activity.slug = 'complete-a-cs-accelerator-course'
  activity.stem_course_template_no = ''
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.description = 'Complete an additional <a href="https://teachcomputing.org/courses?certificate=cs-accelerator" data-event-label="CSA course" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">CS Accelerator course</a> and expand your subject knowledge'
  activity.booking_programme_slug = 'cs-accelerator'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'raise-aspirations-with-a-stem-ambassador-visit') do |activity|
  activity.title = 'Raise aspirations with a STEM Ambassador visit'
  activity.credit = 10
  activity.slug = 'raise-aspirations-with-a-stem-ambassador-visit'
  activity.category = 'community'
  activity.provider = 'stem-learning'
  activity.self_certifiable = true
  activity.description = '<a href="https://www.stem.org.uk/stem-ambassadors/schools-and-colleges" data-event-label="STEM Ambassadors" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">Arrange a visit for your school</a> to help pupils understand real-world applications of computing, and raise their career aspirations through engaging activities. STEM Ambassadors are inspiring and relatable role models who volunteer to support schools.'
  activity.self_verification_info = 'Please provide us with the date and location of the visit'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

Activity.find_or_initialize_by(slug: 'download-and-use-the-i-belong-handbook').tap do |activity|
  activity.title = 'Download and use the I Belong handbook'
  activity.credit = 10
  activity.slug = 'download-and-use-the-i-belong-handbook'
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Download and use the handbook to support your action planning by helping you access a range of recommended resources and initiatives.'

  activity.programmes |= [i_belong_certificate]
end.save

Activity.find_or_initialize_by(slug: 'request-your-i-belong-in-computer-science-posters').tap do |activity|
  activity.title = 'Request your ‘I Belong in Computer Science’ posters'
  activity.credit = 10
  activity.slug = 'request-your-i-belong-in-computer-science-posters'
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = '<a href="https://forms.office.com/e/x1FMMzjxhg">Request</a> and display your set of ‘I Belong in Computer Science’ posters. Consider using with the <a href="https://isaaccomputerscience.org/pages/computer_science_journeys_gallery?examBoard=all&stage=all">interview series</a> to stimulate discussion about computer science related pathways.'

  activity.programmes |= [i_belong_certificate]
end.save

Activity.find_or_initialize_by(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources').tap do |activity|
  activity.title = 'Implement selected key stage 3 Teach Computing Curriculum resources'
  activity.credit = 10
  activity.slug = 'implement-selected-key-stage-3-teach-computing-curriculum-resources'
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Download and plan the use of two or more resources aligned to evidence-based approaches supporting girls’ engagement (see handbook for guidance). Evidence delivery of at least one of these.'
  activity.self_verification_info = 'Please provide us with evidence of delivery of at least one of these'

  activity.programmes |= [i_belong_certificate]
end.save

Activity.find_or_initialize_by(slug: 'participate-in-a-ncce-student-enrichment-activity').tap do |activity|
  activity.title = 'Participate in a National Centre for Computing Education student enrichment activity'
  activity.credit = 10
  activity.slug = 'participate-in-a-ncce-student-enrichment-activity'
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Visit our <a href="#">website</a> for upcoming student events. Consider targeting whole or weighted KS3 female student groups.'
  activity.self_verification_info = 'Please provide us with evidence of participation'

  activity.programmes |= [i_belong_certificate]
end.save

Activity.find_or_initialize_by(slug: 'start-or-deliver-a-computing-related-club').tap do |activity|
  activity.title = 'Start or deliver a computing related club'
  activity.credit = 10
  activity.slug = 'start-or-deliver-a-computing-related-club'
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Deliver a computing related STEM lunchtime or after school club. Consider involving older female students to support. Resources to help you get started are available via the handbook. '
  activity.self_verification_info = 'Please provide us with evidence of delivery'

  activity.programmes |= [i_belong_certificate]
end.save

Activity.find_or_initialize_by(slug: 'host-a-computing-stem-ambassador-activity').tap do |activity|
  activity.title = 'Host a computing STEM Ambassador activity'
  activity.credit = 10
  activity.slug = 'host-a-computing-stem-ambassador-activity'
  activity.category = 'community'
  activity.provider = 'stem-learning'
  activity.self_certifiable = true
  activity.description = 'Host a computing <a href="https://www.stem.org.uk/stem-ambassadors/request-stem-ambassador">STEM Ambassador</a> in your school to help students understand real-world applications of their learning and raise their career aspirations. Consider the diversity of roles available in computing.'
  activity.self_verification_info = 'Please provide us with evidence of delivery'

  activity.programmes |= [i_belong_certificate]
end.save

Activity.find_or_initialize_by(slug: 'participate-in-a-computing-related-competition').tap do |activity|
  activity.title = 'Participate in a computing related competition'
  activity.credit = 10
  activity.slug = 'participate-in-a-computing-related-competition'
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Participate in a competition to develop girls’ enthusiasm and self-belief in computing. Consider targeting whole or weighted KS3 female student groups. '
  activity.self_verification_info = 'Please provide us with evidence of delivery'

  activity.programmes |= [i_belong_certificate]
end.save

Activity.find_or_initialize_by(slug: 'any-other-activity-which-aligns-with-recommendations-from-the-handbook').tap do |activity|
  activity.credit = 10
    activity.slug = 'anyctivity-other-activity-which-aligns-with-recommendations-from-the-handbook'
end.save
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'Complete any other student activity which aligns with recommendations from the handbook. Let us know what you’ve done using the evidence button.'
  activity.self_verification_info = 'Please provide us with evidence of delivery'

  activity.programmes |= [i_belong_certificate]
end
