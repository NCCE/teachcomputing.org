desc 'updates primary certificate data'
task update_primary_data: :environment do
  Rails.logger.warn "Updating primary certificate data"
  p = Programme.primary_certificate

  # Update title and descriptions
  p.activities.find_by(slug: 'contribute-to-online-discussion').update(
    title: 'Contribute to online discussion',
    description: '<a href="https://www.computingatschool.org.uk/account/new-member-application" data-event-label="Join CAS" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Join the Computing at School (CAS) community</a> to explore teaching ideas, resources and best practice with other teachers, engaging in <a href="https://forum.computingatschool.org.uk" data-event-label="Online CAS discussion" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">online discussion forums or webinars</a>. CAS is a grass-roots community of computing educators, offering free, informal sessions for teachers.'
  )

  p.activities.find_by(slug: 'review-a-resource-on-cas').update(
    title: 'Use and feedback on a teaching resource',
    description: 'Download and use a <a href="/curriculum" data-event-label="Curriculum resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Teach Computing Curriculum resource</a>, then reflect on how you used and adapted it in the classroom. You can also use <a href="https://www.computingatschool.org.uk/teaching-resources" data-event-label="CAS resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">CAS teaching resources</a> or <a href="https://www.stem.org.uk/primary-computing-resources" data-event-label="STEM resource" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">STEM primary computing resources</a>. Submit a link to your feedback - this can be a document or screenshot on a shared drive, or a direct link to your review.'
  )

  p.activities.find_by(slug: 'host-or-attend-a-barefoot-workshop').update(
    title: 'Boost the teaching of computing in your school with a free Barefoot Workshop',
    description: '<a href="https://www.barefootcomputing.org/primary-computing-workshops" data-event-label="Barefoot workshop" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Attend a free Barefoot online workshop</a>, designed to boost your subject knowledge and confidence. Workshops are themed around Computational Thinking, Programming in Scratch or Early Years.',
    self_verification_info: 'Please provide us with details of the workshop'
  )

  p.activities.find_by(slug: 'attend-a-cas-community-meeting').update(
    title: 'Gain support and share ideas in a CAS Community meeting',
    description: 'By <a href="https://www.computingatschool.org.uk/about-cas-communities" data-event-label="CAS meeting" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">joining and attending a session at your local Computing at School (CAS) Community</a>, you’ll meet other teachers in similar roles, sharing ideas, resources and insights. CAS is a grass-roots community of computing educators, offering free, informal sessions for teachers.'
  )

  p.activities.find_by(slug: 'run-an-after-school-code-club').update(
    title: 'Help children learn to code at a Code Club',
    description: "Code Club sessions use free step-by-step project guides to enrich young people's experience of programming. You don't need to be an experienced coder to <a href='https://codeclub.org/en/volunteer' data-event-label='Code Club volunteer' data-event-category='Primary enrolled' data-event-action='click' class='ncce-link'>volunteer</a>, and resources and support are on-hand to help you. If there isn't a club set up already at your school, <a href='https://codeclub.org/en/start-a-code-club' data-event-label=' Start a Code Club today' data-event-category='Primary enrolled' data-event-action='click' class='ncce-link'>it's easy to start one</a>."
  )

  p.activities.find_by(slug: 'lead-a-session-at-a-regional-or-national-conference').update(
    title: 'Lead a session at a regional or national conference',
    description: 'Present a session at a conference, for example <a href="https://www.computingatschool.org.uk/events" data-event-label="CAS showcase" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">the annual CAS Virtual Showcase</a> or through <a href="/hubs" data-event-label="Hub showcase" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">your local Computing Hub</a>.'
  )

  p.activities.find_by(slug: 'lead-a-cas-community-of-practice').update(
    title: 'Run a CAS Community of Practice',
    description: '<a href="https://www.computingatschool.org.uk/about-cas-communities/cas-community-leaders" data-event-label="CAS leader" data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Register as a CAS Community leader</a> and run 3 meetings per year. Low maintenance and high impact, it should only take 1 to 2 hours a month to organise each meeting. Provide the name and location of your community.'
  )

  p.activities.find_by(slug: 'providing-additional-support').update(
    title: 'Support computing in your wider community',
    description: "There are lots of ways you can help improve computing education, such as helping parents set up and use virtual classrooms, working collaboratively with teachers in your school, or arranging a computing-themed event in your community. Let us know how you've gone the extra mile in computing."
  )

  # Add computing-on-a-budget to primary and make face-to-face
  a = Activity.find_by(slug: 'computing-on-a-budget')
  a.update(remote_delivered_cpd: false)
  a.programmes << p unless a.programmes.include?(p)

  # Add verification info
  p.activities.find_by(slug: 'raise-aspirations-with-a-stem-ambassador-visit').update(self_verification_info: 'Please provide us with the date and location of the visit')

  # Add pathway pdfs
  Pathway.find_by(slug: 'developing-in-the-classroom').update(pdf_link: 'https://static.teachcomputing.org/primary-pathways/Developing-in-the-Classroom.pdf')
  Pathway.find_by(slug: 'specialising-or-leading').update(pdf_link: 'https://static.teachcomputing.org/primary-pathways/Specialising-or-leading.pdf')

  # Add missing activity code
  p.activities.find_by(slug: 'primary-programming-and-algorithms').update(stem_activity_code: 'CP003')

  # Re create pathways
  PathwayActivity.delete_all
  require_relative '../../db/seeds/pathways/primary_certificate'
end
