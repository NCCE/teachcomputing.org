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

a = Activity.find_or_create_by(stem_course_template_no: "249f1bc2-a5b6-ed11-b597-0022481b59ce") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "9187d975-a6b6-ed11-b597-0022481b59ce") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "ac3bf599-a6b6-ed11-b597-0022481b59ce") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "5dee2821-ce3d-ee11-bdf4-002248c6f9ce") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "3879268d-ce3d-ee11-bdf4-002248c6f783") do |activity|
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

Activity.find_or_create_by(stem_course_template_no: "f670dfa1-ce3d-ee11-bdf4-002248c6f783") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "55cc7b90-a5b6-ed11-b597-0022481b59ce") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "a46bc181-a4b6-ed11-b597-0022481b59ce") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "e9cb65af-a4b6-ed11-b597-0022481b59ce") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "83e7b049-a5b6-ed11-b597-0022481b59ce") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "7ffcf8be-a6b6-ed11-b597-0022481b59ce") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "0bccfb49-a6b6-ed11-b597-0022481b59ce") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "8dbe73ec-cd3d-ee11-bdf4-002248c6f9ce") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "716d350d-ce3d-ee11-bdf4-002248c6f9ce") do |activity|
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

a = Activity.find_or_create_by(stem_course_template_no: "ed5a3948-a4b6-ed11-b597-0022481b59ce") do |activity|
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

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "054037e5-eff8-ef11-bae2-6045bd0da0e9").tap do |activity|
  activity.title = "New leaders of secondary computing"
  activity.credit = 50
  activity.slug = "new-leaders-of-secondary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO411A"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "071de4a9-f7f8-ef11-bae2-0022481add34").tap do |activity|
  activity.title = "Block-based programming for KS3 computing"
  activity.credit = 60
  activity.slug = "block-based-programming-for-ks3-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO237"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "d822d66b-f8f8-ef11-bae2-0022481add34").tap do |activity|
  activity.title = "Encouraging girls into computer science"
  activity.credit = 20
  activity.slug = "encouraging-girls-into-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO440"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "2b01bdd8-01f9-ef11-bae2-002248c763ad").tap do |activity|
  activity.title = "KS3 computing (module 2): Creative curriculum content, sequencing and pedagogy"
  activity.credit = 50
  activity.slug = "ks3-computing-module-2-creative-curriculum-content-sequencing-and-pedagogy-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO248"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "368e09d5-02f9-ef11-bae2-002248c763ad").tap do |activity|
  activity.title = "Preparing for Ofsted in secondary computing"
  activity.credit = 20
  activity.slug = "preparing-for-ofsted-in-secondary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO444"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "36ace116-04f9-ef11-bae2-002248c763ad").tap do |activity|
  activity.title = "Teaching GCSE Computer Science: improving student engagement"
  activity.credit = 60
  activity.slug = "teaching-gcse-computer-science-improving-student-engagement-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO240"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "399f8d65-e8f8-ef11-bae2-6045bd0da0e9").tap do |activity|
  activity.title = "Inclusive computing in primary schools"
  activity.credit = 60
  activity.slug = "inclusive-computing-in-primary-schools-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO005"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "40967a7e-eaf8-ef11-bae2-6045bd0da0e9").tap do |activity|
  activity.title = "Leading primary computing - module 1"
  activity.credit = 60
  activity.slug = "leading-primary-computing-module-1-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO008"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "d86fbc00-ecf8-ef11-bae2-6045bd0da0e9").tap do |activity|
  activity.title = "Maths in primary computing"
  activity.credit = 15
  activity.slug = "maths-in-primary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO418"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "93b8323f-ebf8-ef11-bae2-6045bd0da0e9").tap do |activity|
  activity.title = "Leading primary computing - module 2"
  activity.credit = 60
  activity.slug = "leading-primary-computing-module-2-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO456"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "020a46ab-e9f8-ef11-bae2-6045bd0da0e9").tap do |activity|
  activity.title = "Introduction to the Teach Computing curriculum"
  activity.credit = 15
  activity.slug = "introduction-to-the-teach-computing-curriculum-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO461"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "f7964e5b-e7f8-ef11-bae2-6045bd0da0e9").tap do |activity|
  activity.title = "Careers and enrichment in primary computing"
  activity.credit = 15
  activity.slug = "careers-and-enrichment-in-primary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO441"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "5d099dc9-ecf8-ef11-bae2-6045bd0da0e9").tap do |activity|
  activity.title = "Online safety through primary computing"
  activity.credit = 15
  activity.slug = "online-safety-through-primary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO469"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "663e5f22-a9f9-ef11-bae2-0022481add34").tap do |activity|
  activity.title = "Systems architecture in A Level computer science"
  activity.credit = 30
  activity.slug = "systems-architecture-in-a-level-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO505"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "b67551da-b0f9-ef11-bae2-6045bd0b0fca").tap do |activity|
  activity.title = "Assessment of secondary computing"
  activity.credit = 60
  activity.slug = "assessment-of-secondary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO413"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "85468e71-b3f9-ef11-bae2-002248c763ad").tap do |activity|
  activity.title = "Artificial intelligence (AI) in Key Stage 3 computing"
  activity.credit = 30
  activity.slug = "artificial-intelligence-ai-in-key-stage-3-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO442"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "020622de-b4f9-ef11-bae2-002248c763ad").tap do |activity|
  activity.title = "Assembly language in A Level computer science"
  activity.credit = 25
  activity.slug = "assembly-language-in-a-level-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO501"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "598853ed-b5f9-ef11-bae2-002248c763ad").tap do |activity|
  activity.title = "Boolean logic in A Level computer science"
  activity.credit = 30
  activity.slug = "boolean-logic-in-a-level-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO503"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "2f5ffa87-b9f9-ef11-bae2-002248c763ad").tap do |activity|
  activity.title = "Data structures in A Level Computer Science"
  activity.credit = 60
  activity.slug = "data-structures-in-a-level-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO502"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "d12b85a4-abf9-ef11-bae2-6045bd0da0e9").tap do |activity|
  activity.title = "Python programming constructs: sequencing, selection and iteration"
  activity.credit = 20
  activity.slug = "python-programming-constructs-sequencing-selection-and-iteration-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO223"
  activity.always_on = true

  activity.programmes = [cs_accelerator]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "4eff3a06-adf9-ef11-bae2-6045bd0da0e9").tap do |activity|
  activity.title = "An introduction to computer systems, networking and security in GCSE computer science"
  activity.credit = 20
  activity.slug = "an-introduction-to-computer-systems-networking-and-security-in-gcse-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO438"
  activity.always_on = true

  activity.programmes = [cs_accelerator]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "b56c8818-b2f9-ef11-bae2-002248c763ad").tap do |activity|
  activity.title = "An Introduction to algorithms, programming and data in computer science"
  activity.credit = 20
  activity.slug = "an-introduction-to-algorithms-programming-and-data-in-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO428"
  activity.always_on = true

  activity.programmes = [cs_accelerator]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "e3167d5e-b8f9-ef11-bae2-002248c763ad").tap do |activity|
  activity.title = "Python programming advanced subject knowledge, implementation and testing"
  activity.credit = 20
  activity.slug = "python-programming-advanced-subject-knowledge-implementation-and-testing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO463"
  activity.always_on = true

  activity.programmes = [cs_accelerator]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "dc706988-baf9-ef11-bae2-002248c763ad").tap do |activity|
  activity.title = "Introduction to programming for A Level computer science"
  activity.credit = 60
  activity.slug = "introduction-to-programming-for-a-level-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO517"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "d9d3cc38-bcf9-ef11-bae2-002248c763ad").tap do |activity|
  activity.title = "Maths for A Level Computer Science"
  activity.credit = 30
  activity.slug = "maths-for-a-level-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO518"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "09d8e4ef-72b8-ef11-b8e9-6045bd0c7e50").tap do |activity|
  activity.title = "Getting started in year 1"
  activity.credit = 60
  activity.slug = "getting-started-in-year-1-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO462"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "a9a0c0ae-75b8-ef11-b8e9-6045bd0c7e50").tap do |activity|
  activity.title = "Getting started in year 2"
  activity.credit = 60
  activity.slug = "getting-started-in-year-2-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO466"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "8be1aa9d-7db8-ef11-b8e9-6045bd0c7e50").tap do |activity|
  activity.title = "Getting started in year 3"
  activity.credit = 60
  activity.slug = "getting-started-in-year-3-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO459"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "51d5e002-7fb8-ef11-b8e9-6045bd0c7e50").tap do |activity|
  activity.title = "Getting started in year 4"
  activity.credit = 60
  activity.slug = "getting-started-in-year-4-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO465"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "382745e5-7fb8-ef11-b8e9-6045bd0c7e50").tap do |activity|
  activity.title = "Getting started in year 5"
  activity.credit = 60
  activity.slug = "getting-started-in-year-5-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO460"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "406e8937-80b8-ef11-b8e9-6045bd0c7e50").tap do |activity|
  activity.title = "Getting started in year 6"
  activity.credit = 60
  activity.slug = "getting-started-in-year-6-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO467"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "0ba68557-50fe-ef11-bae3-6045bd0da0e9").tap do |activity|
  activity.title = "Supporting GCSE computer science students at grades 1-3"
  activity.credit = 60
  activity.slug = "supporting-gcse-computer-science-students-at-grades-1-3-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO478"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "3a08b061-51fe-ef11-bae3-6045bd0da0e9").tap do |activity|
  activity.title = "KS3 computing (module 3): Creative curriculum enrichment and inclusion"
  activity.credit = 50
  activity.slug = "ks3-computing-module-3-creative-curriculum-enrichment-and-inclusion-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO249"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "a1f21bd0-52fe-ef11-bae3-6045bd0da0e9").tap do |activity|
  activity.title = "Foundation knowledge of computer science for KS3 and GCSE"
  activity.credit = 20
  activity.slug = "foundation-knowledge-of-computer-science-for-ks3-and-gcse-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO426"
  activity.always_on = true

  activity.programmes = [cs_accelerator]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "89b260f5-53fe-ef11-bae3-6045bd0da0e9").tap do |activity|
  activity.title = "Computing Quality Framework - driving change within your secondary school"
  activity.credit = 20
  activity.slug = "computing-quality-framework-driving-change-within-your-secondary-school-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO406"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "c9536bf0-66fe-ef11-bae3-6045bd0da0e9").tap do |activity|
  activity.title = "Higher attainment in computer science - meeting the challenges of the exams"
  activity.credit = 60
  activity.slug = "higher-attainment-in-computer-science-meeting-the-challenges-of-the-exams-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO439"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "a83fd7af-f5ff-ef11-bae3-0022481add34").tap do |activity|
  activity.title = "Digital literacy in key stage 2 and key stage 3"
  activity.credit = 20
  activity.slug = "digital-literacy-in-key-stage-2-and-key-stage-3-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO904"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "37e3a85a-911b-f011-998a-6045bd0da0e9").tap do |activity|
  activity.title = "Established leaders of secondary computing"
  activity.credit = 60
  activity.slug = "established-leaders-of-secondary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO411B"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "b3b2601b-e420-f011-998a-0022481add34").tap do |activity|
  activity.title = "AI in primary computing"
  activity.credit = 15
  activity.slug = "ai-in-primary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO408"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "e201eba4-f520-f011-998a-0022481add34").tap do |activity|
  activity.title = "Effective computing transition from key stage 2 to key stage 3"
  activity.credit = 15
  activity.slug = "effective-computing-transition-from-key-stage-2-to-key-stage-3-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO415"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "0cef34f4-f920-f011-998a-0022481add34").tap do |activity|
  activity.title = "Leading primary computing - module 3"
  activity.credit = 60
  activity.slug = "leading-primary-computing-module-3-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO009"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "47374939-fb20-f011-998a-0022481add34").tap do |activity|
  activity.title = "Supporting autistic pupils in primary computing"
  activity.credit = 60
  activity.slug = "supporting-autistic-pupils-in-primary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO291"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "3b4de055-f020-f011-998a-0022481add34").tap do |activity|
  activity.title = "Algorithms and programming in key stage 1"
  activity.credit = 60
  activity.slug = "algorithms-and-programming-in-key-stage-1-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO019"
  activity.always_on = true

  activity.programmes = [primary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "415cc9d7-ff24-f011-8c4e-002248c763ad").tap do |activity|
  activity.title = "Advanced Data Structures for A-Level Computer Science"
  activity.credit = 50
  activity.slug = "advanced-data-structures-for-a-level-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO903"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "71d89c47-0425-f011-8c4e-002248c763ad").tap do |activity|
  activity.title = "Object oriented programming (OOP) in A Level computer science"
  activity.credit = 60
  activity.slug = "object-oriented-programming-oop-in-a-level-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO506"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "23cfc421-0725-f011-8c4e-002248c763ad").tap do |activity|
  activity.title = "Pathfinding algorithms in A Level computer science"
  activity.credit = 20
  activity.slug = "pathfinding-algorithms-in-a-level-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO504"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "2d1c9e1c-af25-f011-8c4e-6045bd0c58e0").tap do |activity|
  activity.title = "Adapted teaching and effective learning interventions in secondary computing"
  activity.credit = 60
  activity.slug = "adapted-teaching-and-effective-learning-interventions-in-secondary-computing-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO448"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "f552acb6-b125-f011-8c4e-6045bd0c58e0").tap do |activity|
  activity.title = "AI and Ethics in GCSE computer science"
  activity.credit = 15
  activity.slug = "ai-and-ethics-in-gcse-computer-science-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO427"
  activity.always_on = true

  activity.programmes = [cs_accelerator]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "5cb94dc2-c025-f011-8c4e-6045bd0c58e0").tap do |activity|
  activity.title = "Behaviour for learning in a computing environment"
  activity.credit = 15
  activity.slug = "behaviour-for-learning-in-a-computing-environment-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO468"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "6f5e9497-c325-f011-8c4e-6045bd0c58e0").tap do |activity|
  activity.title = "Python programming: working with data"
  activity.credit = 15
  activity.slug = "python-programming-working-with-data-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO433"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "faadd61b-5c2a-f011-8c4e-002248c763ad").tap do |activity|
  activity.title = "Representing algorithms using flowcharts and pseudocode"
  activity.credit = 15
  activity.slug = "representing-algorithms-using-flowcharts-and-pseudocode-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO420"
  activity.always_on = true

  activity.programmes = [cs_accelerator]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "2bf0fc94-c525-f011-8c4e-6045bd0c58e0").tap do |activity|
  activity.title = "Teaching GCSE computer science improving student engagement"
  activity.credit = 15
  activity.slug = "teaching-gcse-computer-science-improving-student-engagement-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO447"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "7999fd2b-c725-f011-8c4e-6045bd0c58e0").tap do |activity|
  activity.title = "Teaching GCSE Computer Science: pedagogy for programming"
  activity.credit = 15
  activity.slug = "teaching-gcse-computer-science-pedagogy-for-programming-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO242"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!

########################################################################################################################

Activity.find_or_initialize_by(stem_course_template_no: "2c924b42-c825-f011-8c4e-6045bd0c58e0").tap do |activity|
  activity.title = "The internet and cyber security"
  activity.credit = 15
  activity.slug = "the-internet-and-cyber-security-online"
  activity.category = "online"
  activity.self_certifiable = false
  activity.provider = "stem-learning"
  activity.stem_activity_code = "CO432"
  activity.always_on = true

  activity.programmes = [secondary_certificate]
end.save!
