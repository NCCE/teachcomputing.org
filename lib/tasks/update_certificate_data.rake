desc 'updates certificate data'
task update_certificate_data: :environment do
  # Secondary
  Rails.logger.warn "Updating secondary certificate activity data"
  p = Programme.secondary_certificate

  p.activities.find_by(slug: 'complete-a-cs-accelerator-course').update(booking_programme_slug: 'cs-accelerator')

  p.activities.find_by(slug: 'provide-feedback-on-our-curriculum-resources').update(
    title: 'Use and feedback on our curriculum resources',
    description: 'Download and use a <a href="/curriculum" data-event-label="Curriculum resource" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">Teach Computing Curriculum resource</a>, then reflect on how you used and adapted it in the classroom. Submit a link to your feedback - this can be a document or screenshot on a shared drive, or a direct link to your review.',
    self_verification_info: 'Please provide a link to your review',
    uploadable: false
  )

  p.activities.find_by(slug: 'provide-feedback-on-a-cas-resource').update(
    title: 'Use and feedback on a CAS or STEM Learning resource',
    description: 'Download and use a <a href="https://www.computingatschool.org.uk/teaching-resources/secondary-computing" data-event-label="CAS resource" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">CAS teaching resource</a>, or a <a href="https://www.stem.org.uk/secondary-alevel-computing" data-event-label="STEM resource" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">STEM Learning secondary computing resource</a>, then reflect on how you used and adapted it in the classroom. Submit a link to your feedback - this can be a document or screenshot on a shared drive, or a direct link to your review.',
    self_verification_info: 'Please provide a link to your review',
    uploadable: false
  )

  p.activities.find_by(slug: 'complete-a-cs-accelerator-course').update(
    title: 'Complete an additional CS Accelerator course',
    description: 'Complete an additional <a href="https://teachcomputing.org/courses?certificate=cs-accelerator" data-event-label="CSA course" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">CS Accelerator course</a> and expand your subject knowledge'
  )

  p.activities.find_by(slug: 'contribute-to-online-discussion-secondary').update(
    title: 'Contribute to online discussion',
    description: '<a href="https://www.computingatschool.org.uk/account/new-member-application" data-event-label="Join CAS" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">Join the Computing at School (CAS) community</a> to explore teaching ideas, resources and best practice with other teachers, engaging in <a href="https://forum.computingatschool.org.uk" data-event-label="Online CAS discussion" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">online discussion forums or webinars</a>. CAS is a grass-roots community of computing educators, offering free, informal sessions for teachers.'
  )

  p.activities.find_by(slug: 'engage-with-stem-ambassadors').update(
    title: 'Raise aspirations with a STEM Ambassador visit',
    description: '<a href="https://www.stem.org.uk/stem-ambassadors/schools-and-colleges" data-event-label="STEM Ambassadors" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">Arrange a visit for your school</a> to help pupils understand real-world applications of computing, and raise their career aspirations through engaging activities. STEM Ambassadors are inspiring and relatable role models who volunteer to support schools.',
    self_verification_info: 'Please provide us with the date and location of the visit'
  )

  p.activities.find_by(slug: 'answer-5-questions-on-isaac-computer-science').update(
    description: "<a href='https://isaaccomputerscience.org/teachers' data-event-label='Register Isaac CS' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>Log in or register for Isaac Computer Science</a> and <a href='https://isaaccomputerscience.org/topics' data-event-label='Isaac CS topics' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>answer any 5 questions from across the topic sections</a>. Screenshot <a href='https://isaaccomputerscience.org/progress' data-event-label='Isaac CS dashboard' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>your progress dashboard</a> as evidence you have completed this activity."
  )

  p.activities.find_by(slug: 'run-a-code-club-or-coder-dojo').update(
    title: 'Help children learn to code at a Code Club',
    description: "Code Club sessions use free step-by-step project guides to enrich young people's experience of programming. You don't need to be an experienced coder <a href='https://codeclub.org/en/volunteer' data-event-label='Code Club volunteer' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>to volunteer</a>, and resources and support are on-hand to help you. If there isn't a club set up already at your school, <a href='https://codeclub.org/en/start-a-code-club' data-event-label='Start a Code Club today' data-event-category='Secondary enrolled' data-event-action='click' class='ncce-link'>it's easy to start one.</a>",
    self_verification_info: 'Please provide us with the name and postcode of your Code Club'
  )

  p.activities.find_by(slug: 'join-gender-balance-in-computing-programme').update(
    title: 'Gender Balance in Computing Programme (closed to new registrations)',
    description: 'If you took part in our research to support gender balance in computing, then please provide a copy of the email that confirms you signed a Memorandum of Understanding as evidence of your participation.',
    self_verification_info: 'Screenshot of Memorandum of Understanding email'
  )

  p.activities.find_by(slug: 'provide-computing-cpd-in-your-school-or-to-another-local-school').update(
    description: 'Deliver computing CPD in your school, or another local school. Provide details of the training including the date training took place.'
  )

  p.activities.find_by(slug: 'provide-computing-cpd-in-your-school-or-to-another-local-school').update(
    description: 'Support another teacher through the CS Accelerator programme, or support a trainee teacher in qualifying as a computing teacher. Provide details of the role of the person you helped, and how you supported them.',
    self_verification_info: 'Provide the role of the person you helped, and details of how you supported them.'
  )

  p.activities.find_by(slug: 'give-additional-support-to-your-community').update(
    title: 'Support computing in your wider community',
    description: "There are lots of ways you can help improve computing education, such as helping parents set up and use virtual classrooms, working collaboratively with teachers in your school, or arranging a computing-themed event in your community. Let us know how you've gone the extra mile in computing.",
    self_verification_info: 'Please give details of the additional support you have provided'
  )

  p.activities.find_by(slug: 'lead-a-session-at-a-regional-or-national-conference-secondary').update(
    description: 'Present a session at a conference, for example <a href="https://www.computingatschool.org.uk/events" data-event-label="CAS showcase" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">the annual CAS Virtual Showcase</a> or through <a href="/hubs" data-event-label="Hub showcase" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">your local Computing Hub</a>.'
  )

  p.activities.find_by(slug: 'lead-a-cas-community-of-practice-secondary').update(
    title: 'Run a CAS Community of Practice',
    description: '<a href="https://www.computingatschool.org.uk/about-cas-communities/cas-community-leaders" data-event-label="CAS leader" data-event-category="Secondary enrolled" data-event-action="click" class="ncce-link">Register as a CAS Community leader</a> and run 3 meetings per year. Low maintenance and high impact, it should only take 1 to 2 hours a month to organise each meeting. Provide the name and location of your community.'
  )

  # Primary
  Rails.logger.warn "Updating primary certificate activity data"
  p = Programme.primary_certificate

  p.activities.find_by(slug: 'raise-aspirations-with-a-stem-ambassador-visit').update(
    description: '<a href="https://www.stem.org.uk/stem-ambassadors/schools-and-colleges" data-event-label="STEM Ambassadors" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Arrange a visit for your school</a> to help pupils understand real-world applications of computing, and raise their career aspirations through engaging activities. STEM Ambassadors are inspiring and relatable role models who volunteer to support schools.'
  )

  # Clear out ProgrammeActivities and ProgrammeActivityGroupings
  ProgrammeActivity.destroy_all
  Rails.logger.warn "Updating programme activity groupings for primary and secondary certificate"
  ProgrammeActivityGrouping.destroy_all
  require_relative '../../db/seeds/programme_activity_groupings/primary_certificate'
  require_relative '../../db/seeds/programme_activity_groupings/secondary_certificate'
end
