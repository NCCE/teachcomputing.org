# This file contains Activity seeds for online LMS courses in MyLearning

cs_accelerator = Programme.cs_accelerator
primary_certificate = Programme.primary_certificate
secondary_certificate = Programme.secondary_certificate

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "563c4bde-a6b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Teaching Programming to 5- to 11-year-olds"
  activity.credit = 80
  activity.slug = "teaching-programming-to-5-11-year-olds"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO041"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "249f1bc2-a5b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "How Computers Work: Demystifying Computation"
  activity.credit = 20
  activity.slug = "how-computers-work-demystifying-computation"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO206"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "9187d975-a6b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Programming 101: An Introduction to Python for Educators"
  activity.credit = 20
  activity.slug = "programming-101-an-introduction-to-python-for-educators"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO207"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)
a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "ac3bf599-a6b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Programming 102: Think like a Computer Scientist"
  activity.credit = 20
  activity.slug = "programming-102-think-like-a-computer-scientist"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO208"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "5dee2821-ce3d-ee11-bdf4-002248c6f9ce").tap do |activity|
  activity.title = "Introduction to Cybersecurity for Teachers"
  activity.credit = 20
  activity.slug = "introduction-to-cybersecurity-for-teachers"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO216"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "3879268d-ce3d-ee11-bdf4-002248c6f783").tap do |activity|
  activity.title = "Design and Prototype Embedded Computer Systems"
  activity.credit = 20
  activity.slug = "design-and-prototype-embedded-computer-systems"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO218"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

Activity.find_or_create_by(stem_course_template_no: "f670dfa1-ce3d-ee11-bdf4-002248c6f783").tap do |activity|
  activity.title = "Introduction to Encryption and Cryptography"
  activity.credit = 20
  activity.slug = "design-and-prototype-embedded-computer-systems"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO220"
  activity.always_on = true
  activity.programmes = [cs_accelerator]
end.save!

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "55cc7b90-a5b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Data Representation in Computing: Bring Data to Life"
  activity.credit = 20
  activity.slug = "representing-data-with-images-and-sound-bringing-data-to-life"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO209"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "a46bc181-a4b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Object-oriented Programming in Python: Create Your Own Adventure Game"
  activity.credit = 20
  activity.slug = "object-oriented-programming-in-python-create-your-own-adventure-game"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO210"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "e9cb65af-a4b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Understanding Computer Systems"
  activity.credit = 20
  activity.slug = "understanding-computer-systems"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO212"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "63c44113-a4b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Impact of Technology: How To Lead Classroom Discussions"
  activity.credit = 20
  activity.slug = "impact-of-technology-how-to-lead-classroom-discussions"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO215"
  activity.always_on = true

  activity.programmes = [cs_accelerator, secondary_certificate]
end.save!

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "83e7b049-a5b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Programming with GUIs"
  activity.credit = 20
  activity.slug = "programming-with-guis"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO217"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "7ffcf8be-a6b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Programming 103: Saving and Structuring Data"
  activity.credit = 20
  activity.slug = "programming-103-saving-and-structuring-data"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO219"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "0bccfb49-a6b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Introduction to Web Development"
  activity.credit = 20
  activity.slug = "introduction-to-web-development"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO221"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "0d17c907-a5b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Programming Pedagogy in Secondary Schools: Inspiring Computing Teaching"
  activity.credit = 80
  activity.slug = "programming-pedagogy-in-secondary-schools-inspiring-computing-teaching"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO222"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "8dbe73ec-cd3d-ee11-bdf4-002248c6f9ce").tap do |activity|
  activity.title = "Understanding Maths and Logic in Computer Science"
  activity.credit = 20
  activity.slug = "understanding-maths-and-logic-in-computer-science"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO213"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "716d350d-ce3d-ee11-bdf4-002248c6f9ce").tap do |activity|
  activity.title = "An Introduction to Computer Networking for Teachers"
  activity.credit = 20
  activity.slug = "an-introduction-to-computer-networking-for-teachers"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO214"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "e83971ba-ce3d-ee11-bdf4-002248c6f783").tap do |activity|
  activity.title = "How to utilise the teach computing curriculum effectively (Key Stages 3 and 4)"
  activity.credit = 80
  activity.slug = "how-to-utilise-the-teach-computing-curriculum-effectively-key-stages-3-and-4)"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO230"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "e9a303e0-ce3d-ee11-bdf4-002248c6f783").tap do |activity|
  activity.title = "Introduction to Machine Learning and AI"
  activity.credit = 80
  activity.slug = "introduction-to-machine-learning-and-ai"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO231"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "ed5a3948-a4b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Introduction to Databases and SQL"
  activity.credit = 20
  activity.slug = "introduction-to-databases-and-sql"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO225"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "06e59bb7-a1b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Introduction to Programming with Scratch"
  activity.credit = 80
  activity.slug = "introduction-to-programming-with-scratch"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO232"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "f6a9f913-cd3d-ee11-bdf4-002248c6f9ce").tap do |activity|
  activity.title = "Get started with the Teach Computing Curriculum in your primary school"
  activity.credit = 80
  activity.slug = "get-started-with-the-teach-computing-curriculum-in-your-primary-school"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO040"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "0a70f9ad-cd3d-ee11-bdf4-002248c6f9ce").tap do |activity|
  activity.title = "Teaching Computing Systems and Networks to 5 to 11 year olds"
  activity.credit = 80
  activity.slug = "teaching-computing-systems-and-networks-to-5-to-11-year-olds"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO042"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "ded270cb-a4b6-ed11-b597-0022481b59ce").tap do |activity|
  activity.title = "Creating an Inclusive Classroom: Approaches to Supporting Learners with SEND in Computing"
  activity.credit = 80
  activity.slug = "creating-an-inclusive-classroom-approaches-to-supporting-learners-with-send-in-computing"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO700"
  activity.always_on = true

  activity.programmes = [primary_certificate, secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "74674e39-eeed-ef11-9342-002248c6bc9f").tap do |activity|
  activity.title = "KS3 computing (module 1): Creative curriculum design principles"
  activity.credit = 50
  activity.slug = "ks3-computing-module-1-creative-curriculum-design-principles-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO247"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "6abeb4f1-c9ee-ef11-9341-6045bd0abf27").tap do |activity|
  activity.title = "Introduction to primary computing"
  activity.credit = 60
  activity.slug = "introduction-to-primary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO454"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "b33e199b-d6ea-ef11-9342-6045bd0c7e50").tap do |activity|
  activity.title = "Developing and supporting programming within your primary school"
  activity.credit = 60
  activity.slug = "developing-and-supporting-programming-within-your-primary-school-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO003"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "c4ec9601-daea-ef11-9341-002248c8ecdf").tap do |activity|
  activity.title = "Empowering girls in key stage 2 computing"
  activity.credit = 20
  activity.slug = "empowering-girls-in-key-stage-2-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO409"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "af01836d-e2ea-ef11-9341-002248c8ecdf").tap do |activity|
  activity.title = "Adapting the Teach Computing Curriculum for mixed-year classes"
  activity.credit = 20
  activity.slug = "adapting-the-teach-computing-curriculum-for-mixed-year-classes-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO404"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "dfe72774-e4ea-ef11-9342-002248c60b03").tap do |activity|
  activity.title = "Assessment of primary computing"
  activity.credit = 60
  activity.slug = "assessment-of-primary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO007"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "fe7a28ac-e5ea-ef11-9342-002248c60b03").tap do |activity|
  activity.title = "Computational thinking in primary schools"
  activity.credit = 20
  activity.slug = "computational-thinking-in-primary-schools-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO457"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "9600665b-e6ea-ef11-9342-002248c60b03").tap do |activity|
  activity.title = "Introduction to the micro:bit in key stage 2"
  activity.credit = 20
  activity.slug = "introduction-to-microbit-key-stage-2-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO292"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "1b3a1493-e7ea-ef11-9341-6045bd0d2e35").tap do |activity|
  activity.title = "Literacy via primary computing - building vocabulary and embedding literacy skills"
  activity.credit = 20
  activity.slug = "literacy-via-primary-computing-building-vocabulary-embedding-literacy-skills-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO407"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "fbdb2a39-e8ea-ef11-9341-6045bd0d2e35").tap do |activity|
  activity.title = "Preparing for Ofsted in primary computing"
  activity.credit = 20
  activity.slug = "preparing-for-ofsted-in-primary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO486"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "891a93e4-e8ea-ef11-9341-6045bd0d2e35").tap do |activity|
  activity.title = "Teaching programming using Scratch and Scratch Jr"
  activity.credit = 60
  activity.slug = "teaching-programming-using-scratch-and-scratch-jr-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO455"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "74afc4a5-fef4-ef11-be20-0022481add34").tap do |activity|
  activity.title = "Empowering trainee teachers:Introduction to primary computing"
  activity.credit = 60
  activity.slug = "empowering-trainee-teachers-introduction-to-primary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO417"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "967de7bb-b6f5-ef11-be20-002248c763ad").tap do |activity|
  activity.title = "Computing Quality Framework – driving change within your primary school"
  activity.credit = 15
  activity.slug = "computing-quality-framework–driving-change-within-your-primary-school-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO403"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!
