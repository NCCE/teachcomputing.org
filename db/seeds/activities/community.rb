include ExternalLinkHelper

# We shouldn't define activity relations in this file
ProgrammeActivity.joins(:activity).where(activity: {category: "community"}).destroy_all
PathwayActivity.joins(:activity).where(activity: {category: "community"}).destroy_all

Activity.find_or_create_by(slug: "contribute-to-online-discussion") do |activity|
  activity.title = "Contribute to online discussion"
  activity.credit = 5
  activity.slug = "contribute-to-online-discussion"
  activity.category = "community"
  activity.provider = "cas"
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide a link to your contribution"
  activity.description = '<a href="https://www.computingatschool.org.uk/account/new-member-application" data-event-label="Join CAS" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Join the Computing at School (CAS) community</a> to explore teaching ideas, resources and best practice with other teachers, engaging in <a href="https://forum.computingatschool.org.uk" data-event-label="Online CAS discussion" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">online discussion forums or webinars</a>. CAS is a grass-roots community of computing educators, offering free, informal sessions for teachers.'
end

Activity.find_or_create_by(slug: "contribute-to-online-discussion-secondary") do |activity|
  activity.title = "Contribute to online discussion"
  activity.credit = 5
  activity.slug = "contribute-to-online-discussion-secondary"
  activity.category = "community"
  activity.provider = "cas"
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide a link to your contribution"
  activity.description = '<a href="https://www.computingatschool.org.uk/account/new-member-application" data-event-label="Join CAS" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">Join the Computing at School (CAS) community</a> to explore teaching ideas, resources and best practice with other teachers, engaging in <a href="https://forum.computingatschool.org.uk" data-event-label="Online CAS discussion" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">online discussion forums or webinars</a>. CAS is a grass-roots community of computing educators, offering free, informal sessions for teachers.'
end

Activity.find_or_create_by(slug: "attend-a-cas-community-meeting") do |activity|
  activity.title = "Gain support and share ideas in a CAS Community meeting"
  activity.slug = "attend-a-cas-community-meeting"
  activity.credit = 10
  activity.category = "community"
  activity.provider = "cas"
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide the date and venue details of the meeting"
  activity.description = 'By <a href="https://www.computingatschool.org.uk/about-cas-communities" data-event-label="CAS meeting" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">joining and attending a session at your local Computing at School (CAS) Community</a>, you’ll meet other teachers in similar roles, sharing ideas, resources and insights. CAS is a grass-roots community of computing educators, offering free, informal sessions for teachers.'
end

Activity.find_or_create_by(slug: "attend-a-cas-community-meeting-secondary") do |activity|
  activity.title = "Attend a CAS Community meeting"
  activity.credit = 10
  activity.slug = "attend-a-cas-community-meeting-secondary"
  activity.category = "community"
  activity.provider = "cas"
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide the date and venue details of the meeting"
  activity.description = 'Join <a href="https://community.computingatschool.org.uk/communities" data-event-label="CAS meeting" class="ncce-link">your local CAS Community </a>and attend a session. You’ll meet other teachers in your area and get to share best practice. Provide the date and event details'
end

Activity.find_or_create_by(slug: "review-a-resource-on-cas") do |activity|
  activity.title = "Use and feedback on a teaching resource"
  activity.credit = 10
  activity.slug = "review-a-resource-on-cas"
  activity.category = "community"
  activity.provider = "cas"
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide a link to your contribution"
  activity.description = 'Download and use a <a href="/curriculum" data-event-label="Curriculum resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Teach Computing Curriculum resource</a>, then reflect on how you used and adapted it in the classroom. You can also use <a href="https://www.computingatschool.org.uk/teaching-resources" data-event-label="CAS resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">CAS teaching resources</a> or <a href="https://www.stem.org.uk/primary-computing-resources" data-event-label="STEM resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">STEM primary computing resources</a>. Submit a link to your feedback - this can be a document or screenshot on a shared drive, or a direct link to your review.'
end

Activity.find_or_create_by(slug: "provide-feedback-on-a-cas-resource") do |activity|
  activity.title = "Use and feedback on a CAS or STEM Learning resource"
  activity.credit = 10
  activity.slug = "provide-feedback-on-a-cas-resource"
  activity.category = "community"
  activity.provider = "cas"
  activity.description = 'Download and use a <a href="https://www.computingatschool.org.uk/teaching-resources" data-event-label="CAS resource" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">CAS teaching resource</a>, or a <a href="https://www.stem.org.uk/secondary-alevel-computing" data-event-label="STEM resource" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">STEM Learning secondary computing resource</a>, then reflect on how you used and adapted it in the classroom. Submit a link to your feedback - this can be a document or screenshot on a shared drive, or a direct link to your review.'
  activity.self_verification_info = "Please provide a link to your review"
  activity.uploadable = false
end

Activity.find_or_create_by(slug: "host-or-attend-a-barefoot-workshop") do |activity|
  activity.title = "Boost the teaching of computing in your school with a free Barefoot Workshop"
  activity.credit = 10
  activity.slug = "host-or-attend-a-barefoot-workshop"
  activity.category = "community"
  activity.provider = "barefoot"
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide us with details of the workshop"
  activity.description = '<a href="https://www.barefootcomputing.org/primary-computing-workshops" data-event-label="Barefoot workshop" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Attend a free Barefoot online workshop</a>, designed to boost your subject knowledge and confidence. Workshops are themed around Computational Thinking, Programming in Scratch or Early Years.'
end

Activity.find_or_create_by(slug: "lead-a-cas-community-of-practice") do |activity|
  activity.title = "Run a CAS Community of Practice"
  activity.credit = 20
  activity.slug = "lead-a-cas-community-of-practice"
  activity.category = "community"
  activity.provider = "cas"
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide us with the name and postcode of the CAS community you're leading"
  activity.description = '<a href="https://www.computingatschool.org.uk/about-cas-communities/cas-community-leaders" data-event-label="CAS leader" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Register as a CAS Community leader</a> and run 3 meetings per year. Low maintenance and high impact, it should only take 1 to 2 hours a month to organise each meeting. Provide the name and location of your community.'
end

Activity.find_or_create_by(slug: "lead-a-cas-community-of-practice-secondary") do |activity|
  activity.title = "Run a CAS Community of Practice"
  activity.credit = 20
  activity.slug = "lead-a-cas-community-of-practice-secondary"
  activity.category = "community"
  activity.provider = "cas"
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide us with the name and postcode of the CAS community you're leading"
  activity.description = '<a href="https://www.computingatschool.org.uk/about-cas-communities/cas-community-leaders" data-event-label="CAS leader" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">Register as a CAS Community leader</a> and run 3 meetings per year. Low maintenance and high impact, it should only take 1 to 2 hours a month to organise each meeting. Provide the name and location of your community.'
end

Activity.find_or_create_by(slug: "providing-additional-support") do |activity|
  activity.title = "Support computing in your wider community"
  activity.credit = 20
  activity.slug = "providing-additional-support"
  activity.category = "community"
  activity.provider = "cas"
  activity.self_certifiable = true
  activity.self_verification_info = "Please give details of the additional support you have provided"
  activity.description = "There are lots of ways you can help improve computing education, such as helping parents set up and use virtual classrooms, working collaboratively with teachers in your school, or arranging a computing-themed event in your community. Let us know how you've gone the extra mile in computing."
end

Activity.find_or_create_by(slug: "run-an-after-school-code-club") do |activity|
  activity.title = "Help children learn to code at a Code Club"
  activity.credit = 20
  activity.slug = "run-an-after-school-code-club"
  activity.category = "community"
  activity.provider = "raspberrypi"
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide us with the name and postcode of your Code Club"
  activity.description = "Code Club sessions use free step-by-step project guides to enrich young people's experience of programming. You don't need to be an experienced coder to <a href='https://codeclub.org/en/volunteer' data-event-label='Code Club volunteer' data-event-category='Primary enrolled' data-event-action='click' class='ncce-link'>volunteer</a>, and resources and support are on-hand to help you. If there isn't a club set up already at your school, <a href='https://codeclub.org/en/start-a-code-club' data-event-label=' Start a Code Club today' data-event-category='Primary enrolled' data-event-action='click' class='ncce-link'>it's easy to start one</a>."
end

Activity.find_or_create_by(slug: "lead-a-session-at-a-regional-or-national-conference") do |activity|
  activity.title = "Lead a session at a regional or national conference"
  activity.credit = 20
  activity.slug = "lead-a-session-at-a-regional-or-national-conference"
  activity.category = "community"
  activity.provider = "cas"
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide us with a link conference programme"
  activity.description = 'Present a session at a conference, for example <a href="https://www.computingatschool.org.uk/events" data-event-label="CAS showcase" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">the annual CAS Virtual Showcase</a> or through <a href="/hubs" data-event-label="Hub showcase" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">your local Computing Hub</a>.'
end

Activity.find_or_create_by(slug: "lead-a-session-at-a-regional-or-national-conference-secondary") do |activity|
  activity.title = "Lead a session at a regional or national conference"
  activity.credit = 20
  activity.slug = "lead-a-session-at-a-regional-or-national-conference-secondary"
  activity.category = "community"
  activity.provider = "cas"
  activity.self_certifiable = true
  activity.description = 'Present a session at a conference, for example <a href="https://www.computingatschool.org.uk/events" data-event-label="CAS showcase" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">the annual CAS Virtual Showcase</a> or through <a href="/hubs" data-event-label="Hub showcase" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">your local Computing Hub</a>.'
  activity.self_verification_info = "Please provide us with a link conference programme"
end

Activity.find_or_create_by(slug: "provide-feedback-on-our-curriculum-resources") do |activity|
  activity.title = "Use and feedback on our curriculum resources"
  activity.credit = 10
  activity.slug = "provide-feedback-on-our-curriculum-resources"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = 'Download and use a <a href="/curriculum" data-event-label="Curriculum resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Teach Computing Curriculum resource</a>, then reflect on how you used and adapted it in the classroom. Submit a link to your feedback - this can be a document or screenshot on a shared drive, or a direct link to your review.'
  activity.self_verification_info = "Please provide a link to your review"
  activity.uploadable = false
end

Activity.find_or_create_by(slug: "provide-computing-cpd-in-your-school-or-to-another-local-school") do |activity|
  activity.title = "Provide computing CPD in your school or to another local school"
  activity.credit = 10
  activity.slug = "provide-computing-cpd-in-your-school-or-to-another-local-school"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = "Deliver computing CPD in your school, or another local school. Provide details of the training including the date training took place."
  activity.self_verification_info = "Provide details of the training including date training took place"
end

Activity.find_or_create_by(slug: "become-a-mentor") do |activity|
  activity.title = "Become a mentor"
  activity.credit = 10
  activity.slug = "become-a-mentor"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = "Support another teacher through the CS Accelerator programme, or support a trainee teacher in qualifying as a computing teacher. Provide details of the role of the person you helped, and how you supported them."
  activity.self_verification_info = "Provide the role of the person you helped, and details of how you supported them."
end

Activity.find_or_create_by(slug: "give-additional-support-to-your-community") do |activity|
  activity.title = "Support computing in your wider community"
  activity.credit = 10
  activity.slug = "give-additional-support-to-your-community"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = "There are lots of ways you can help improve computing education, such as helping parents set up and use virtual classrooms, working collaboratively with teachers in your school, or arranging a computing-themed event in your community. Let us know how you've gone the extra mile in computing."
  activity.self_verification_info = "Please give details of the additional support you have provided"
end

Activity.find_or_create_by(slug: "join-gender-balance-in-computing-programme") do |activity|
  activity.title = "Gender Balance in Computing Programme (closed to new registrations)"
  activity.credit = 10
  activity.slug = "join-gender-balance-in-computing-programme"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = "If you took part in our research to support gender balance in computing, then please provide a copy of the email that confirms you signed a Memorandum of Understanding as evidence of your participation."
  activity.self_verification_info = "Screenshot of Memorandum of Understanding email"
  activity.uploadable = true
end

Activity.find_or_create_by(slug: "answer-5-questions-on-isaac-computer-science") do |activity|
  activity.title = "Answer 5 questions on Isaac Computer Science"
  activity.credit = 10
  activity.slug = "answer-5-questions-on-isaac-computer-science"
  activity.category = "community"
  activity.provider = "isaac"
  activity.self_certifiable = true
  activity.description = "<a href='https://isaaccomputerscience.org/teachers' data-event-label='Register Isaac CS' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>Log in or register for Isaac Computer Science</a> and <a href='https://isaaccomputerscience.org/topics' data-event-label='Isaac CS topics' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>answer any 5 questions from across the topic sections</a>. Screenshot <a href='https://isaaccomputerscience.org/progress' data-event-label='Isaac CS dashboard' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>your progress dashboard</a> as evidence you have completed this activity."
  activity.self_verification_info = "Provide screenshot of your progress dashboard"
  activity.uploadable = true
end

Activity.find_or_create_by(slug: "engage-with-stem-ambassadors") do |activity|
  activity.title = "Raise aspirations with a STEM Ambassador visit"
  activity.credit = 10
  activity.slug = "engage-with-stem-ambassadors"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = '<a href="https://www.stem.org.uk/stem-ambassadors/schools-and-colleges" data-event-label="STEM Ambassadors" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">Arrange a visit for your school</a> to help pupils understand real-world applications of computing, and raise their career aspirations through engaging activities. STEM Ambassadors are inspiring and relatable role models who volunteer to support schools.'
  activity.self_verification_info = "Please provide us with the date and location of the visit"
end

Activity.find_or_create_by(slug: "run-a-code-club-or-coder-dojo") do |activity|
  activity.title = "Help children learn to code at a Code Club"
  activity.credit = 10
  activity.slug = "run-a-code-club-or-coder-dojo"
  activity.category = "community"
  activity.provider = "raspberrypi"
  activity.self_certifiable = true
  activity.description = "Code Club sessions use free step-by-step project guides to enrich young people's experience of programming. You don't need to be an experienced coder <a href='https://codeclub.org/en/volunteer' data-event-label='Code Club volunteer' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>to volunteer</a>, and resources and support are on-hand to help you. If there isn't a club set up already at your school, <a href='https://codeclub.org/en/start-a-code-club' data-event-label='Start a Code Club today' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>it's easy to start one.</a>"
  activity.self_verification_info = "Please provide us with the name and postcode of your Code Club"
end

Activity.find_or_create_by(slug: "complete-a-cs-accelerator-course") do |activity|
  activity.title = "Complete an additional CS Accelerator course"
  activity.credit = 10
  activity.slug = "complete-a-cs-accelerator-course"
  activity.stem_course_template_no = ""
  activity.category = "community"
  activity.provider = "ncce"
  activity.description = 'Complete an additional <a href="https://teachcomputing.org/courses?certificate=cs-accelerator" data-event-label="CSA course" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">CS Accelerator course</a> and expand your subject knowledge'
  activity.booking_programme_slug = "cs-accelerator"
end

Activity.find_or_initialize_by(slug: "raise-aspirations-with-a-stem-ambassador-visit").tap do |activity|
  activity.title = "Raise aspirations with a STEM Ambassador visit"
  activity.credit = 10
  activity.slug = "raise-aspirations-with-a-stem-ambassador-visit"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "<a href='#{stem_ambassadors_url}'>Arrange an in-person or online visit</a> for your classroom to help pupils understand real-world applications of computing and raise their career aspirations."
  activity.public_copy_description = "<a href='#{stem_ambassadors_url}'>Arrange an in-person or online visit</a> for your classroom to help pupils understand real-world applications of computing and raise their career aspirations."
  activity.public_copy_title_url = stem_ambassadors_url
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "Add the date(s) and who the visit was aimed at. Include the age range of students involved.",
      "What was the activity?",
      "What topics were covered?",
      "How many STEM Ambassadors attended, what their names were and which companies/universities etc. were they from?",
      "What was the impact of the visit on your students? Share an example of student voice/comment if possible."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "participate-fully-in-an-ncce-curriculum-enrichment-oppertunity").tap do |activity|
  activity.title = "Participate fully in an NCCE or partner curriculum enrichment opportunity"
  activity.credit = 10
  activity.slug = "participate-fully-in-an-ncce-curriculum-enrichment-oppertunity"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Encourage young people to develop important life and subject knowledge skills through <a href='/secondary-enrichment'>enrichment</a> and engage with the wider community in practical, enjoyable, and meaningful ways. For example, you and your students can attend an <a href='#{isaac_url}'>Isaac Computer Science</a> and/or <a href='#{ncce_eventbrite_url}'>I Belong</a> event or participate in the <a href='#{i_am_computer_scientist_url}'>I’m a Computer Scientist</a> activity. "
  activity.public_copy_description = "Encourage young people to develop important life and subject knowledge skills through <a href='/secondary-enrichment'>enrichment</a> and engage with the wider community in practical, enjoyable, and meaningful ways. For example, you and your students can attend an <a href='#{isaac_url}'>Isaac Computer Science</a> and/or <a href='#{ncce_eventbrite_url}'>I Belong</a> event or participate in the <a href='#{i_am_computer_scientist_url}'>I’m a Computer Scientist</a> activity. "
  activity.public_copy_title_url = "http://www.teachcomputing.org/secondary-enrichment"
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "Add the date, name and any other details of an NCCE or partner opportunity that you and your students have participated in.",
      "What did your students learn? If possible, share an example of your students’ feedback.",
      "What was the impact of the activity on your students? Share an example of student voice/comment if possible.",
      "Explain how this activity will enrich students’ experience of the computing curriculum."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "participate-fully-in-an-ncce-curriculum-enrichment-oppertunity-primary").tap do |activity|
  activity.title = "Explore the NCCE and partner enrichment opportunities and resources and plan to run an enrichment activity in your school"
  activity.credit = 10
  activity.slug = "participate-fully-in-an-ncce-curriculum-enrichment-oppertunity-primary"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Explore NCCE and partner <a href='https://teachcomputing.org/primary-enrichment'>enrichment resources</a> to enable you to plan an enrichment activity in your classroom."
  activity.public_copy_description = "Explore NCCE and partner <a href='https://teachcomputing.org/primary-enrichment'>enrichment resources</a> to enable you to plan an enrichment activity in your classroom."
  activity.public_copy_title_url = "http://www.teachcomputing.org/primary-enrichment"
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "Describe the enrichment activity are you going to run in your classroom.",
      "When are you planning it for?",
      "What year group is this activity intended for?",
      "Explain how this activity will enrich pupils' experience of the computing curriculum."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "implement-your-professional-development-in-the-classroom-and-evaluate-via-the-impact-toolkit").tap do |activity|
  activity.title = "Implement your professional development in the classroom and evaluate through our Impact Toolkit"
  activity.title = "Implement your professional development in the classroom and evaluate through our Impact Toolkit"
  activity.credit = 10
  activity.slug = "implement-your-professional-development-in-the-classroom-and-evaluate-via-the-impact-toolkit"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Think about not only your actions but also <a href='#{impact_toolkit_url}'>collecting evidence</a> of how the changes you make impact you, your colleagues, and your students."
  activity.public_copy_description = "Think about not only your actions but also <a href='#{impact_toolkit_url}'>collecting evidence</a> of how the changes you make impact you, your colleagues, and your students."
  activity.public_copy_title_url = impact_toolkit_url
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "Add information on how you’ve implemented what you learnt from CPD into your classroom and how you used the Impact Toolkit to evaluate your learning."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "download-and-use-the-ncce-teaching-and-assessment-resources-in-your-classroom").tap do |activity|
  activity.title = "Reflect on the use of a NCCE teaching and assessment resource(s) in your classroom"
  activity.credit = 10
  activity.slug = "download-and-use-the-ncce-teaching-and-assessment-resources-in-your-classroom"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Download and use a <a href='https://teachcomputing.org/curriculum'>Teach Computing Curriculum resource(s)</a>, then reflect on how you used and adapted it in the classroom."
  activity.public_copy_description = "Download and use a <a href='https://teachcomputing.org/curriculum'>Teach Computing Curriculum resource(s)</a>, then reflect on how you used and adapted it in the classroom."
  activity.public_copy_title_url = "https://teachcomputing.org/curriculum"
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "Reflect on the use of the <a href='https://teachcomputing.org/curriculum'>Teach Computing Curriculum resource(s)</a>, including which year group you taught and when.",
      "Include the unit, lesson and name of the resource(s) that you used. Include a link to the resource(s) on the Teach Computing website if possible."
    ]
  }]
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "Reflect on the use of the <a href='https://teachcomputing.org/curriculum'>Teach Computing Curriculum resource(s)</a>, including which year group you taught and when.",
      "Include the unit, lesson and name of the resource(s) that you used. Include a link to the resource(s) on the Teach Computing website if possible."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "share-tips-on-using-an-ncce-resource-in-your-classroom-with-colleagues-on-stem-community").tap do |activity|
  activity.title = "Start or contribute to a discussion thread on STEM Community to share tips on using a NCCE resource in your classroom"
  activity.credit = 10
  activity.slug = "share-tips-on-using-an-ncce-resource-in-your-classroom-with-colleagues-on-stem-community"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "By joining <a href='#{stem_community_url}'>STEM Community</a> you’ll meet other teachers in similar roles and be able to share ideas, resources and insights."
  activity.public_copy_description = "By joining <a href='#{stem_community_url}'>STEM Community</a> you’ll meet other teachers in similar roles and be able to share ideas, resources and insights."
  activity.public_copy_title_url = "https://community.stem.org.uk/home"
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "Share a link(s) to where you have contributed to the discussion(s) on the STEM Community about using a NCCE resource(s). You can also contribute to the existing <a href='#{primary_evidence_stem_community_url}'>primary certificate evidence thread</a>."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "support-other-teachers-and-earn-a-stem-community-participation-badge-secondary").tap do |activity|
  activity.title = "Support other teachers and earn a participation badge on a STEM Community platform"
  activity.credit = 10
  activity.slug = "support-other-teachers-and-earn-a-stem-community-participation-badge-secondary"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "By joining <a href='#{stem_community_url}'>STEM Community</a> you’ll meet other teachers in similar roles and be able to share ideas, resources and insights. You’ll earn points for your activities on the <a href='#{stem_community_url}'>STEM Community</a>. Your points add up, and over time you will be <a href='#{stem_community_points_help_url}'>rewarded with badges</a> in recognition of your activity and participation in the community."
  activity.public_copy_description = "By joining <a href='#{stem_community_url}'>STEM Community</a> you’ll meet other teachers in similar roles and be able to share ideas, resources and insights. You’ll earn points for your activities on the <a href='#{stem_community_url}'>STEM Community</a>. Your points add up, and over time you will be <a href='#{stem_community_points_help_url}'>rewarded with badges</a> in recognition of your activity and participation in the community."
  activity.public_copy_title_url = stem_community_points_help_url
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "What is the highest STEM Community participation badge you have earned? You can find your badge in your account details under the ‘Awards’ section.",
      "Describe the engagement activities you did to earn a badge.",
      "Include a link to a sharing folder with a screenshot of your STEM Community badge. Please make sure it is open for viewing by anybody with the correct link."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "support-other-teachers-and-earn-a-stem-community-participation-badge").tap do |activity|
  activity.title = "Support other teachers and earn a participation badge on a STEM Community platform"
  activity.credit = 10
  activity.slug = "support-other-teachers-and-earn-a-stem-community-participation-badge"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "By joining <a href='#{stem_community_url}'>STEM Community</a> you’ll meet other teachers in similar roles and be able to share ideas, resources and insights. You’ll earn points for your posts and comments on the <a href='#{stem_community_url}'>STEM Community</a>. Your points add up, and over time you will be <a href='#{stem_community_points_help_url}'>rewarded with badges</a> in recognition of your activity and participation in the community."
  activity.public_copy_description = "By joining <a href='#{stem_community_url}'>STEM Community</a> you’ll meet other teachers in similar roles and be able to share ideas, resources and insights. You’ll earn points for your posts and comments on the <a href='#{stem_community_url}'>STEM Community</a>. Your points add up, and over time you will be <a href='#{stem_community_points_help_url}'>rewarded with badges</a> in recognition of your activity and participation in the community."
  activity.public_copy_title_url = "https://community.stem.org.uk/helpfaqs/points"
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "What is the highest STEM Community participation badge you have earned? You can find your badge in your account details under the ‘Awards’ section.",
      "Describe the engagement activities you did to earn a badge.",
      "Include a link to a sharing folder with a screenshot of your STEM Community badge. Please make sure it is open for viewing by anybody with the correct link."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "run-or-support-a-code-club-in-your-school").tap do |activity|
  activity.title = "Run or support a Code Club in your school"
  activity.credit = 10
  activity.slug = "run-or-support-a-code-club-in-your-school"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = '<a href="https://codeclub.org/en/start-a-code-club">Code Club sessions</a> use free step-by-step project guides to enrich young people’s experience of programming. If there isn’t a club set up already at your school, it’s easy to start one.'
  activity.public_copy_description = "Code Club sessions use free step-by-step project guides to enrich young people’s experience of programming. If there isn’t a club set up already at your school, it’s easy to start one."
  activity.public_copy_title_url = "https://codeclub.org/en/start-a-code-club"
  activity.self_verification_info = "Please provide us with evidence of guide usage"
end.save!

Activity.find_or_initialize_by(slug: "run-an-enrichment-activity-in-your-classroom").tap do |activity|
  activity.title = "Run an enrichment activity in your school"
  activity.credit = 10
  activity.slug = "run-an-enrichment-activity-in-your-classroom"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Enrich the curriculum by running a computing <a href='https://teachcomputing.org/primary-enrichment'>enrichment activity</a> in your school, such as a computing-themed club, a computing day or week at your school etc."
  activity.public_copy_description = "Enrich the curriculum by running a computing <a href='https://teachcomputing.org/primary-enrichment'>enrichment activity</a> in your school, such as a computing-themed club, a computing day or week at your school etc."
  activity.public_copy_title_url = "https://teachcomputing.org/primary-enrichment"
  activity.self_verification_info = nil
  activity.public_copy_evidence = [
    {
      brief: "Evidence guidance:",
      bullets: [
        "Add the date(s) and any other details of the enrichment activity that you have ran with pupils in your classroom.",
        "What was the activity?",
        "What was the age range of pupils involved?",
        "What did they learn?",
        "What was the impact of the activity? If possible, include feedback from the pupils, and any links to websites, news articles etc."
      ]
    }
  ]
end.save!

Activity.find_or_initialize_by(slug: "download-and-use-the-i-belong-handbook").tap do |activity|
  activity.title = "Download and use an I Belong handbook"
  activity.credit = 10
  activity.slug = "download-and-use-the-i-belong-handbook"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = nil
  activity.coming_soon = false
  activity.public_copy_submission_options = [
    {
      slug: "primary-handbook",
      title: "Primary handbook",
      redirect: i_belong_primary_handbook_url,
      redownload: true,
      default: false
    },
    {
      slug: "secondary-handbook",
      title: "Secondary handbook",
      redirect: i_belong_secondary_handbook_url,
      redownload: true,
      default: true
    }
  ]
end.save!

Activity.find_or_initialize_by(slug: "request-your-i-belong-in-computer-science-posters").tap do |activity|
  activity.title = "Request your ‘I Belong in Computer Science’ posters"
  activity.credit = 10
  activity.slug = "request-your-i-belong-in-computer-science-posters"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = nil
  activity.public_copy_submission_options = [
    {
      slug: "i-belong-certificate-request",
      title: "Request",
      redirect: i_belong_poster_request_url,
      redownload: false,
      default: true
    }
  ]
end.save!

Activity.find_or_initialize_by(slug: "implement-selected-key-stage-3-teach-computing-curriculum-resources").tap do |activity|
  activity.title = "Implement selected Teach Computing Curriculum resources"
  activity.credit = 10
  activity.slug = "implement-selected-key-stage-3-teach-computing-curriculum-resources"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = "Download and plan two or more resources aligned to evidence-based approaches supporting girls' engagement, see your primary and secondary handbook for guidance."
  activity.self_verification_info = "Please provide us with evidence of delivery of at least one of these"
  activity.public_copy_evidence = [
    {
      brief: "Tell us which units you’ve been teaching, to which year group, and when."
    },
    {
      brief: "Tell us how you added approaches from the 'Encouraging Girls' or ‘Empowering girls’ course into your teaching. Examples may include:",
      bullets: [
        "Increasing pupils’ sense of ‘belonging’ with different ways of working together",
        "Using near-peer and relatable role models to link careers into the computing curriculum",
        "Boosting girls’ self-efficacy when teaching units such as programming by implementing effective pedagogies such as pair programming"
      ]
    },
    {
      brief: "Tell us the impact of what you did. Share your reflections and add examples of evidence, such as:",
      bullets: [
        "Documenting changes in girls’ participation levels after implementing the resources (may include student voice)",
        "Examples where collaborative working or project-based activities have increased girls’ participation",
        "Reflect on the use of strategies to boost girls' self-efficacy, such as targeted feedback, peer collaboration",
        "Showcase successful projects by female pupils, on the school website and share them with family to support family engagement"
      ]
    }
  ]
end.save!

Activity.find_or_initialize_by(slug: "participate-in-a-ncce-student-enrichment-activity").tap do |activity|
  activity.title = "Participate in an I Belong student event"
  activity.credit = 10
  activity.slug = "participate-in-a-ncce-student-enrichment-activity"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = "Find out about upcoming events by visiting our <a href='#{ncce_student_events_url}'>Eventbrite</a>."
  activity.self_verification_info = "Please provide us with evidence of participation"
  activity.public_copy_evidence = [
    {
      brief: "Tell us which event your students participated in. Describe the activity including when it took place. Include the age range of students involved, the total number and the proportion of female and male pupils."
    },
    {
      brief: "Tell us which approaches from the 'Encouraging Girls' or ‘Empowering girls’ course were used. Examples might include:",
      bullets: [
        "Being part of a supportive team at the event – increasing the proportion of girls participating",
        "Using near-peer mentors, such as older pupils - increasing identity",
        "Family engagement – increasing social capital",
        "Considering prior experiences and access to computing at home – advancing equity"
      ]
    },
    {
      brief: "What was the impact of the event? Share your reflections and add examples of evidence, such as:",
      bullets: [
        "Positive feedback from pupils, a link to a newsletter covering the event or a blogpost from the school website",
        "A link to an online news story or social media post from your school’s account to summarise the event",
        "Option data showing an increase in the proportion of girls considering GCSE Computer Science in KS4"
      ]
    }
  ]
end.save!

Activity.find_or_initialize_by(slug: "provide-access-to-a-computing-related-extracurricular-club").tap do |activity|
  activity.title = "Provide access to a computing-related extracurricular club"
  activity.credit = 10
  activity.slug = "provide-access-to-a-computing-related-extracurricular-club"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = "Provide access to a computing related STEM lunchtime or after school club. Consider involving older female students to support."
  activity.self_verification_info = "Please provide us with evidence of delivery"
  activity.public_copy_evidence = [{
    brief: "Tell us what you did and when. Describe your computing club in school and include timescales, particularly if you’ve run the club for longer than a year. Include the age range of pupils involved, and the proportion of female and male pupils. How do you promote a higher proportion of girls participating? Finally, reflect and tell us why you chose this activity."
  },
    {
      brief: "Which approaches from the 'Encouraging Girls' or ‘Empowering girls’ course have you considered or used? Examples might include:",
      bullets: [
        "Inviting female pupils during lessons or family events to increase the proportion of girls taking part",
        "Having a choice of activities including physical computing or themed projects such as climate challenges or creating music",
        "Setting up girls-only clubs to empower them to question, experiment and lead",
        "Including competitive activities in a supportive setting such as the CyberFirst Girls or CanSat challenges",
        "Using near-peer mentors (such as older pupils or computing ambassadors)"
      ]
    },
    {
      brief: "What is the impact of the club? Write your reflections and add examples of evidence, which might include:",
      bullets: [
        "Positive feedback from pupils, a link to a newsletter covering the event or a blogpost from the school website",
        "Sharing a link to an online news story or social media post from your school’s account about a success in a competition or club activities",
        "Option data showing an increase in the proportion of girls considering GCSE Computer Science in KS4"
      ]
    }]
end.save!

Activity.find_or_initialize_by(slug: "host-a-computing-stem-ambassador-activity").tap do |activity|
  activity.title = "Host a Computing Ambassador activity"
  activity.credit = 10
  activity.slug = "host-a-computing-stem-ambassador-activity"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Host a <a href='#{stem_request_ambassador_url}'>Computing Ambassador</a> in your school. Raising gender and career aspirations and help students understand the real-world applications of learning."
  activity.self_verification_info = "Please provide us with evidence of delivery"
  activity.public_copy_evidence = [{
    brief: "Tell us what you did and when. Was it a one-off visit from a computing ambassador or part of a series of events you’ve organised in school? Include the age range of students involved, and the proportion of female and male pupils. How did you promote a higher proportion of girls participating?"
  },
    {
      brief: "Which approaches from the 'Encouraging Girls' or ‘Empowering girls’ course can you share in how you planned the activity? Examples might include:",
      bullets: [
        "Linking the visit to the curriculum to add real world contexts",
        "Inviting relatable role models to link careers into the computing curriculum",
        "Choosing a topic such as AI, health or environmental themes for activities that are about ‘people not things’"
      ]
    },
    {
      brief: "What was the impact? What have you observed following the interventions you’ve put in place? Examples might include:",
      bullets: [
        "Positive feedback from pupils, a link to a newsletter covering the event or a blogpost from the school website",
        "A link to an online news story or social media post from your school’s account summarising the activity",
        "Option data showing an increase in the proportion of girls considering GCSE Computer Science in KS4"
      ]
    }]
end.save!

Activity.find_or_initialize_by(slug: "participate-in-a-computing-related-competition").tap do |activity|
  activity.title = "Participate in a computing related competition"
  activity.credit = 10
  activity.slug = "participate-in-a-computing-related-competition"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = "Participate in a competition this academic year to develop girls’ enthusiasm and self-belief in computing. Visit the <a href='/primary-enrichment'>primary</a> or <a href='/secondary-enrichment'>secondary</a> enrichment pages for more information."
  activity.self_verification_info = "Please provide us with evidence of delivery"
  activity.public_copy_evidence = [
    {
      brief: "Tell us which competition your students entered into and when. Include the age range of pupils involved, and the proportion of girls taking part."
    },
    {
      brief: "Which approaches from the 'Encouraging Girls' or ‘Empowering girls’ course helped to increase the proportion of girls participating in the competition? Examples might include:",
      bullets: [
        "Inviting female pupils during lessons or family engagement events to promote self-efficacy and participation",
        "Building a supportive team with competitions in a club setting",
        "Setting up girls-only teams to empower them to question, experiment and lead",
        "Involving near-peer mentors such as older pupils or computing ambassadors"
      ]
    },
    {
      brief: "What was the impact? What have you observed following the interventions you’ve put in place? Examples might include:",
      bullets: [
        "Positive feedback from pupils, a link to a newsletter covering the event or a blogpost from the school website",
        "A link to an online news story or school social media post about a success in a competition or club activity",
        "Option data showing an increase in the proportion of girls considering GCSE Computer Science in KS4"
      ]
    }
  ]
end.save!

Activity.find_or_initialize_by(slug: "any-other-activity-which-aligns-with-recommendations-from-the-handbook").tap do |activity|
  activity.title = "Any other activity which aligns with recommendations from the handbook"
  activity.credit = 10
  activity.slug = "any-other-activity-which-aligns-with-recommendations-from-the-handbook"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = %(Complete any other student activity which aligns with recommendations from the handbook. Let us know what you’ve done using the evidence button.)
  activity.self_verification_info = "Please provide us with evidence of delivery"
  activity.public_copy_evidence = [
    {
      brief: "Tell us which activity your students have got involved with and when it took place. Include the age range of all the pupils involved, the total number and the proportion of girls and boys."
    },
    {
      brief: "Which approaches from the 'Encouraging Girls' or ‘Empowering girls’ course can you share in the way you planned the activity? Examples might include:",
      bullets: [
        "Creating opportunities for family engagement",
        "Setting up girls-only opportunities to empower them to question, experiment and lead",
        "Inviting near-peer and relatable role models to link careers into the computing curriculum",
        "Bringing in relevance such as AI, health or environmental themes for activities that are about ‘people not things’"
      ]
    },
    {
      brief: "What was the impact? What have you observed following the interventions you’ve put in place? Examples might include:",
      bullets: [
        "Positive feedback from pupils, a link to a newsletter covering the event or a blogpost from the school website",
        "A link to an online news story or school social media post about a success in a competition or club activities",
        "Option data showing an increase in the proportion of girls considering GCSE Computer Science in KS4"
      ]
    }
  ]
end.save!

# here
Activity.find_or_initialize_by(slug: "start-or-deliver-a-computing-related-club").tap do |activity|
  activity.title = "Start or deliver a computing related club"
  activity.credit = 10
  activity.slug = "start-or-deliver-a-computing-related-club"
  activity.category = "community"
  activity.provider = "ncce"
  activity.self_certifiable = true
  activity.description = "Deliver a computing related STEM lunchtime or after school club. Consider involving older female students to support. Resources to help you get started are available via the <a href=\"#{i_belong_secondary_handbook_url}\">handbook</a>. Evidence must showcase club activities hosted from April 2023 onwards."
  activity.self_verification_info = "Please provide us with evidence of delivery"
end.save!

Activity.find_or_initialize_by(slug: "gain-accreditation-as-a-professional-development-leader").tap do |activity|
  activity.title = "Gain <a href='#{leading_professional_development_url}'>accreditation</a> as a professional development leader"
  activity.credit = 10
  activity.slug = "gain-accreditation-as-a-professional-development-leader"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Reflect on what makes CPD effective and how its impact can be evaluated as well as the strategies and tools you’ll need when <a href='#{leading_professional_development_url}'>leading learning</a> with teachers."
  activity.public_copy_description = "Reflect on what makes CPD effective and how its impact can be evaluated as well as the strategies and tools you’ll need when <a href='#{leading_professional_development_url}'>leading learning</a> with teachers."
  activity.public_copy_title_url = leading_professional_development_url
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "Reflect on what makes CPD effective and how its impact can be evaluated as well as the strategies and tools you’ll need when <a href='#{leading_professional_development_url}'>leading learning</a> with teachers.",
      "Include the title of the specific <a href='#{leading_professional_development_url}'>accreditation</a> that you have gained."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "undertake-the-initial-assessment-of-your-school-using-computing-quality-framework").tap do |activity|
  activity.title = "Undertake the initial assessment of your school using <a href='#{computing_quality_framework_url}'>Computing Quality Framework</a>"
  activity.credit = 10
  activity.slug = "undertake-the-initial-assessment-of-your-school-using-computing-quality-framework"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Review your <a href='#{computing_quality_framework_url}'>school’s progress</a> in developing an exemplary computing curriculum and work towards achieving the <a href='#{computing_quality_framework_url}'>Computing Quality Mark.</a>"
  activity.public_copy_description = "Review your <a href='#{computing_quality_framework_url}'>school’s progress</a> in developing an exemplary computing curriculum and work towards achieving the <a href='#{computing_quality_framework_url}'>Computing Quality Mark.</a>"
  activity.public_copy_title_url = computing_quality_framework_url
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "How were you involved in the initial assessment?",
      "Include your average level across all benchmarks of the CQF. You can also add a link to a sharing folder with a screenshot of your school’s initial assessment graph. Make sure the viewing permissions are open to anyone with the link."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "work-with-your-local-computing-hub-to-develop-a-school-level-action-plan-for-professional-development").tap do |activity|
  activity.title = "Work with your local Computing Hub to develop a school-level action plan for professional development"
  activity.credit = 10
  activity.slug = "work-with-your-local-computing-hub-to-develop-a-school-level-action-plan-for-professional-development"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "<a href='/hubs'>Computing Hubs</a> support local schools with their journey in developing the computing curriculum using a free <a href='#{computing_quality_framework_url}'>Computing Quality Framework</a> tool. Your local Hub will work with you to identify your computing needs and provide a targeted programme of support."
  activity.public_copy_description = "<a href='/hubs'>Computing Hubs</a> support local schools with their journey in developing the computing curriculum using a free <a href='#{computing_quality_framework_url}'>Computing Quality Framework</a> tool. Your local Hub will work with you to identify your computing needs and provide a targeted programme of support."
  activity.public_copy_title_url = local_hub_professional_development_form_url
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "What local Computing Hub did you work with?",
      "What is your current average level across all benchmarks of the <a href='#{computing_quality_framework_url}'>Computing Quality Framework</a>?",
      "Outline the improvement actions required to achieve the next level in your school-level action plan."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "lead-your-school-into-a-computing-cluster-and-develop-an-action-plan-with-a-cluster-advisor").tap do |activity|
  activity.title = "Lead your school into a Computing Cluster"
  activity.credit = 10
  activity.slug = "lead-your-school-into-a-computing-cluster-and-develop-an-action-plan-with-a-cluster-advisor"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "<a href='https://teachcomputing.org/computing-clusters'>Join a group of 3-8 eligible schools</a>, which receive targeted support in professional learning to make progress within the <a href='#{computing_quality_framework_url}'>Computing Quality Framework</a> over a 12-month period "
  activity.public_copy_description = "<a href='https://teachcomputing.org/computing-clusters'>Join a group of 3-8 eligible schools</a>, which receive targeted support in professional learning to make progress within the <a href='#{computing_quality_framework_url}'>Computing Quality Framework</a> over a 12-month period "
  activity.public_copy_title_url = "https://teachcomputing.org/computing-clusters"
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "Please provide us with evidence of joining. Include the name of your school and your Cluster advisor."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "join-and-present-at-your-local-computing-at-school-community").tap do |activity|
  activity.title = "Join one of the Computing at School Communities and present at a community meeting"
  activity.title = "Join one of the Computing at School Communities and present at a community meeting"
  activity.credit = 10
  activity.slug = "join-and-present-at-your-local-computing-at-school-community"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "<a href='#{cas_communities_url}'>Computing at School</a> (CAS) Communities are a great way to connect with other teachers, share resources, join discussions in the forums or share something you've created. Join a local event and offer your insights, ideas and expertise to colleagues. "
  activity.public_copy_description = "<a href='#{cas_communities_url}'>Computing at School</a> (CAS) Communities are a great way to connect with other teachers, share resources, join discussions in the forums or share something you've created. Join a local event and offer your insights, ideas and expertise to colleagues. "
  activity.public_copy_title_url = cas_communities_url
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "Add information on what CAS community you’ve joined, what community meeting(s) you have participated in and elaborate on your presentation."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "join-the-ib-encouraging-girls-into-cs-programme-and-become-an-ibc").tap do |activity|
  activity.title = "Join the I Belong: Encouraging Girls into Computer Science programme, and become an I Belong Champion"
  activity.credit = 10
  activity.slug = "join-the-ib-encouraging-girls-into-cs-programme-and-become-an-ibc"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = '<a href="https://teachcomputing.org/i-belong">I Belong</a> is an evidence-based programme which aims to support more girls into computer science qualifications and careers by providing you with the knowledge and tools to support them.'
  activity.public_copy_description = "I Belong is an evidence-based programme which aims to support more girls into computer science qualifications and careers by providing you with the knowledge and tools to support them."
  activity.public_copy_title_url = "https://teachcomputing.org/i-belong"
  activity.self_verification_info = "Please provide us with evidence of your registration"
end.save!

Activity.find_or_initialize_by(slug: "download-and-use-isaac-computer-science-classroom-resources-and-displays").tap do |activity|
  activity.title = "Reflect on the use of the Isaac Computer Science platform and resources in your classroom"
  activity.credit = 10
  activity.slug = "download-and-use-isaac-computer-science-classroom-resources-and-displays"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Bring learning to life with <a href='#{isaac_journey_gallery_url}'>Computer Science Journeys</a>, <a href='#{isaac_journey_careers_url}'>Careers in Computer Science videos</a>, and request printed versions of the ‘I Belong in Computer Science’ posters from the NCCE to put in your classroom. "
  activity.public_copy_description = "Bring learning to life with <a href='#{isaac_journey_gallery_url}'>Computer Science Journeys</a>, <a href='#{isaac_journey_careers_url}'>Careers in Computer Science videos</a>, and request printed versions of the ‘I Belong in Computer Science’ posters from the NCCE to put in your classroom. "
  activity.public_copy_title_url = isaac_journey_gallery_url
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "Tell us where you put up the ‘I Belong in Computer Science’ posters.",
      "Share how and what <a href='#{isaac_journey_gallery_url}'>Computer Science Journeys</a> and <a href='#{isaac_journey_careers_url}'>Careers in Computer Science videos</a> you have introduced to your students in class. Include the age range of students involved.",
      "What was the impact of the activity on your students? Share an example of student voice/comment if possible."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "work-with-local-business-and-industry-to-inspire-inclusive-computing").tap do |activity|
  activity.title = "Work with local business and industry to inspire inclusive computing"
  activity.credit = 10
  activity.slug = "work-with-local-business-and-industry-to-inspire-inclusive-computing"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Establish <a href='#{stem_secondary_ambassadors_url}'>relationships with businesses</a> in your local area, that can support development of inclusive computing in your school. "
  activity.public_copy_description = "Establish <a href='#{stem_secondary_ambassadors_url}'>relationships with businesses</a> in your local area, that can support development of inclusive computing in your school. "
  activity.public_copy_title_url = stem_secondary_ambassadors_url
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "Tell us who you are working with and how you have worked together.",
      "What impact did this partnership have on the development of inclusive computing in your school?"
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "gain-accreditation-as-an-i-belong-champion").tap do |activity|
  activity.title = "Gain accreditation as an I Belong Champion"
  activity.credit = 10
  activity.slug = "gain-accreditation-as-an-i-belong-champion"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = 'Become an <a href="https://teachcomputing.org/i-belong">I Belong Champion</a> to showcase your passion for inclusion and advocate for and create a sense of belonging for girls in computer science.'
  activity.public_copy_description = "Become an I Belong Champion to showcase your passion for inclusion and advocate for and create a sense of belonging for girls in computer science."
  activity.public_copy_title_url = "https://teachcomputing.org/i-belong"
  activity.self_verification_info = "Please provide us with evidence of completion"
end.save!

Activity.find_or_initialize_by(slug: "become-an-i-belong-champion").tap do |activity|
  activity.title = "Become an I Belong Champion"
  activity.credit = 10
  activity.slug = "become-an-i-belong-champion"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Lead your school, and others, in creating the right conditions for more girls to succeed in computing. Become an <a href='/i-belong'>I Belong Champion</a> to showcase your passion for inclusion and advocate for and create a sense of belonging for girls in computer science. Complete the <a href='https://teachcomputing.org/courses/CO440/encouraging-girls-into-computer-science-online'>‘Encouraging girls into GCSE computer science’</a> course, learn about the whole <a href='/i-belong'>programme</a> and become a Champion... then encourage more people to join the mission!"
  activity.public_copy_description = "Lead your school, and others, in creating the right conditions for more girls to succeed in computing. Become an <a href='/i-belong'>I Belong Champion</a> to showcase your passion for inclusion and advocate for and create a sense of belonging for girls in computer science. Complete the <a href='https://teachcomputing.org/courses/CO440/encouraging-girls-into-computer-science-online'>‘Encouraging girls into GCSE computer science’</a> course, learn about the whole <a href='/i-belong'>programme</a> and become a Champion... then encourage more people to join the mission!"
  activity.public_copy_title_url = "https://teachcomputing.org/i-belong"
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "When did you complete the <a href='https://teachcomputing.org/courses/CO440/encouraging-girls-into-computer-science-online'>‘Encouraging girls into GCSE computer science’</a> course?",
      "Tell us how you have supported colleagues in your school to become aware of the I Belong programme.",
      "Tell us how you have spread the word to help other teachers access the I Belong programme. You may have shared information with not only your teaching colleagues, but also school trusts, local computing communities and social media.",
      "Add links to an online news story, blogpost or social media post where you have encouraged others to join."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "become-an-i-belong-champion-primary").tap do |activity|
  activity.title = "Become an I Belong Champion"
  activity.credit = 10
  activity.slug = "become-an-i-belong-champion-primary"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Lead your school, and others, in creating the right conditions for more girls to succeed in computing. Become an <a href='/i-belong'>I Belong Champion</a> to showcase your passion for inclusion and advocate for and create a sense of belonging for girls in computer science. Complete the <a href='https://teachcomputing.org/courses/CO409/empowering-girls-in-key-stage-2-computing-online'>Empowering girls in key stage 2 computing</a> course, learn about the whole programme and become a Champion... then encourage more people to join the mission!"
  activity.public_copy_description = "Lead your school, and others, in creating the right conditions for more girls to succeed in computing. Become an <a href='/i-belong'>I Belong Champion</a> to showcase your passion for inclusion and advocate for and create a sense of belonging for girls in computer science. Complete the <a href='https://teachcomputing.org/courses/CO409/empowering-girls-in-key-stage-2-computing-online'>Empowering girls in key stage 2 computing</a> course, learn about the whole programme and become a Champion... then encourage more people to join the mission!"
  activity.public_copy_title_url = "https://teachcomputing.org/i-belong"
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance",
    bullets: [
      "Tell us how you have supported colleagues in your school to become aware of the I Belong programme for KS2.",
      "Tell us how you have spread the word to help other teachers access the I Belong programme. You may have shared information with not only your teaching colleagues, but also school trusts, local computing communities and social media.",
      "Add links to an online news story, blogpost or social media post where you have encouraged others to join."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "complete-the-i-belong-programme-as-a-school").tap do |activity|
  activity.title = "Complete the I Belong Programme as a school"
  activity.credit = 10
  activity.slug = "complete-the-i-belong-programme-as-a-school"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Once you’ve completed the short, remote course <a href='https://teachcomputing.org/courses/CO440/encouraging-girls-into-computer-science-online'>‘Encouraging girls into GCSE computer science’</a> you’ll be ready to bring enrichment activities, role models and inclusive teaching practices to your school. The I Belong handbook contains everything you need to know to reach this goal. "
  activity.public_copy_description = "Once you’ve completed the short, remote course <a href='https://teachcomputing.org/courses/CO440/encouraging-girls-into-computer-science-online'>‘Encouraging girls into GCSE computer science’</a> you’ll be ready to bring enrichment activities, role models and inclusive teaching practices to your school. The I Belong handbook contains everything you need to know to reach this goal. "
  activity.public_copy_title_url = "https://teachcomputing.org/i-belong"
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence gudiance:",
    bullets: [
      "How were you involved in the completion of the I Belong programme? What did you do to increase girls’ engagement?",
      "Add information about positive impacts that you have observed since completing the programme, such as an increased interest in computing activities, positive interactions with parents, or a wider diversity in club attendance."
    ]
  }]
end.save!

Activity.find_or_initialize_by(slug: "complete-the-i-belong-programme-as-a-school-primary").tap do |activity|
  activity.title = "Complete the I Belong Programme as a school"
  activity.credit = 10
  activity.slug = "complete-the-i-belong-programme-as-a-school-primary"
  activity.category = "community"
  activity.provider = "stem-learning"
  activity.self_certifiable = true
  activity.description = "Once you’ve completed the short, remote course <a href='https://teachcomputing.org/courses/CO409/encouraging-girls-into-gcse-computer-science-remote-short-course-online'>‘Empowering girls in key stage 2 computing’</a> you’ll be ready to bring enrichment activities, role models and inclusive teaching practices to your school. The I Belong handbook contains everything you need to know to reach this goal."
  activity.public_copy_description = "Once you’ve completed the short, remote course <a href='https://teachcomputing.org/courses/CO409/encouraging-girls-into-gcse-computer-science-remote-short-course-online'>‘Empowering girls in key stage 2 computing’</a> you’ll be ready to bring enrichment activities, role models and inclusive teaching practices to your school. The I Belong handbook contains everything you need to know to reach this goal."
  activity.public_copy_title_url = "https://teachcomputing.org/i-belong"
  activity.self_verification_info = nil
  activity.public_copy_evidence = [{
    brief: "Evidence guidance:",
    bullets: [
      "How were you involved in the completion of the I Belong programme? What did you do to increase girls’ engagement?",
      "Add information about positive impacts that you have observed since completing the programme, such as an increased interest in computing activities, positive interactions with parents, or a wider diversity in club attendance."
    ]
  }]
end.save!
