# This file contains Activity seeds for online LMS courses in MyLearning

cs_accelerator = Programme.cs_accelerator
primary_certificate = Programme.primary_certificate
secondary_certificate = Programme.secondary_certificate

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: '563c4bde-a6b6-ed11-b597-0022481b59ce').tap do |activity|
  activity.title = 'Teaching Programming to 5- to 11-year-olds'
  activity.credit = 10
  activity.slug = 'teaching-programming-to-5-11-year-olds'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO041'
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: '249f1bc2-a5b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'How Computers Work: Demystifying Computation'
  activity.credit = 20
  activity.slug = 'how-computers-work-demystifying-computation'
  activity.category = 'online'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO206'
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: '9187d975-a6b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Programming 101: An Introduction to Python for Educators'
  activity.credit = 20
  activity.slug = 'programming-101-an-introduction-to-python-for-educators'
  activity.category = 'online'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO207'
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)
a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: 'ac3bf599-a6b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Programming 102: Think like a Computer Scientist'
  activity.credit = 20
  activity.slug = 'programming-102-think-like-a-computer-scientist'
  activity.category = 'online'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO208'
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: '55cc7b90-a5b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Data Representation in Computing: Bring Data to Life'
  activity.credit = 20
  activity.slug = 'representing-data-with-images-and-sound-bringing-data-to-life'
  activity.category = 'online'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO209'
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: 'a46bc181-a4b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Object-oriented Programming in Python: Create Your Own Adventure Game'
  activity.credit = 20
  activity.slug = 'object-oriented-programming-in-python-create-your-own-adventure-game'
  activity.category = 'online'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO210'
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: 'e9cb65af-a4b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Understanding Computer Systems'
  activity.credit = 20
  activity.slug = 'understanding-computer-systems'
  activity.category = 'online'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO212'
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: '63c44113-a4b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Impact of Technology: How To Lead Classroom Discussions'
  activity.credit = 20
  activity.slug = 'impact-of-technology-how-to-lead-classroom-discussions'
  activity.category = 'online'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO215'
  activity.always_on = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)
a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)


########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: '83e7b049-a5b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Programming with GUIs'
  activity.credit = 20
  activity.slug = 'programming-with-guis'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO217'
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: '7ffcf8be-a6b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Programming 103: Saving and Structuring Data'
  activity.credit = 20
  activity.slug = 'programming-103-saving-and-structuring-data'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO219'
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: '0bccfb49-a6b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Introduction to Web Development'
  activity.credit = 20
  activity.slug = 'introduction-to-web-development'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO221'
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: '0d17c907-a5b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Programming Pedagogy in Secondary Schools: Inspiring Computing Teaching'
  activity.credit = 20
  activity.slug = 'programming-pedagogy-in-secondary-schools-inspiring-computing-teaching'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO222'
  activity.always_on = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: 'ed5a3948-a4b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Introduction to Databases and SQL'
  activity.credit = 20
  activity.slug = 'introduction-to-databases-and-sql'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO225'
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: '06e59bb7-a1b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Introduction to Programming with Scratch'
  activity.credit = 20
  activity.slug = 'introduction-to-programming-with-scratch'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO232'
  activity.always_on = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: 'ded270cb-a4b6-ed11-b597-0022481b59ce') do |activity|
  activity.title = 'Creating an Inclusive Classroom: Approaches to Supporting Learners with SEND in Computing'
  activity.credit = 20
  activity.slug = 'creating-an-inclusive-classroom-approaches-to-supporting-learners-with-send-in-computing'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CO700'
  activity.always_on = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)
a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

########################################################################################################################
