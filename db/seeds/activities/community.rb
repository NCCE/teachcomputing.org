primary_certificate = Programme.primary_certificate
# secondary_certificate = Programme.secondary_certificate

a = Activity.find_or_create_by(slug: 'contribute-to-online-discussion') do |activity|
  activity.title = 'Contribute to online discussion'
  activity.credit = 5
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide a link to your contribution'
  activity.description = 'Engage in the CAS online discussion forums and webinars in a meaningful way.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)
# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'attend-a-cas-community-meeting') do |activity|
  activity.title = 'Attend a CAS Community meeting'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide the date and venue details of the meeting'
  activity.description = 'CAS Community meetings are a great place to meet up with teachers in your area and share best practice. To find your local CAS Community visit- <a href="https://www.computingatschool.org.uk/">www.computingatschool.org.uk</a>.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)
# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'review-a-resource-on-cas') do |activity|
  activity.title = 'Review a resource on CAS'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide a link to your contribution'
  activity.description = 'Head over to the CAS website to give a full review of a resource you’ve downloaded and used including how you used it in the classroom. <a href="https://community.computingatschool.org.uk/resources/2616/single">You can find CAS resources here</a>'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)
# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'host-or-attend-a-barefoot-workshop') do |activity|
  activity.title = 'Host or attend a Barefoot Workshop'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'barefoot'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with the date and location of the workshop'
  activity.description = 'Barefoot workshops enable you to explore the Barefoot materials, concepts and approaches with a Barefoot volunteer. You can request a free workshop over on the <a href="https://www.barefootcomputing.org/">Barefoot computing website</a>'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)
# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'lead-a-cas-community-of-practice') do |activity|
  activity.title = 'Lead a CAS Community of Practice'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide us with the name and postcode of the CAS community you're leading"
  activity.description = 'Support the CAS Community further by registering as a CAS Community Leader through the <a href="https://community.computingatschool.org.uk/" class="ncce-link"> CAS website</a>. You’ll need to commit to running 3 meetings per year to support your local community.'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)
# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'providing-additional-support') do |activity|
  activity.title = 'Providing Additional Support'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = "Please give details of the additional support you have provided"
  activity.description = 'Providing additional support your local community of teachers, pupils or parents during the school closure period'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)
# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'run-an-after-school-code-club') do |activity|
  activity.title = 'Run an after-school Code Club'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'code-club'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with the name and postcode of your Code Club'
  activity.description = 'Code Club supports schools and teachers nationwide to run free after-school coding clubs for 9- to 13-year-olds. <a href="https://codeclub.org/en/start-a-code-club" class="ncce-link">Start a Code Club today</a>'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)
# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

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
# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'download-use-and-provide-meaningful-feedback-on-a-resource-from-the-teach-computing-curriculum') do |activity|
  activity.title = 'Download, use and provide meaningful feedback on a resource from the Teach Computing Curriculum'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.self_verification_info = 'Provide screenshot of feedback'
end

# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'provide-computing-cpd-in-your-school-or-to-another-local-school') do |activity|
  activity.title = 'Provide computing CPD in your school or to another local school'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.self_verification_info = 'Provide details of the training including date training took place'
end

# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'become-a-mentor-support-another-teacher-through-the-cs-accelerator-programme-support-a-trainee-teacher') do |activity|
  activity.title = 'Become a mentor – support another teacher through the CS Accelerator programme, support a trainee teacher'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.self_verification_info = 'Provide details of who/how you provided support'
end

# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'give-additional-support-beyond-your-day-to-day-teaching-to-your-local-community-of-teachers-pupils-or-parents') do |activity|
  activity.title = 'Give additional support, beyond your day to day teaching, to your local community of teachers, pupils or parents'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.self_verification_info = 'Provide details of support provided'
end

# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'register-to-participate-in-the-gender-balance-in-computing-programme') do |activity|
  activity.title = 'Register to participate in the Gender Balance in Computing Programme'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'ncce'
  activity.self_certifiable = true
  activity.description = 'details can be found here <a href="https://teachcomputing.org/gender-balance" class="ncce-link">(https://teachcomputing.org/gender-balance)</a>'
  activity.self_verification_info = 'Screenshot to show registration'
end

# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'volunteer-to-run-an-event-with-the-isaac-computer-science-programme') do |activity|
  activity.title = 'Volunteer to run an event with the ISAAC Computer Science programme'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'isaac'
  activity.self_certifiable = true
  activity.self_verification_info = 'Provide link to the event'
end

# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'engage-with-stem-ambassadors') do |activity|
  activity.title = 'Engage with STEM Ambassadors'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'stem-learning'
  activity.self_certifiable = true
  activity.self_verification_info = ''
end

# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)
