# This file contains seeds for Activities facilitated by FutureLearn, that have since been retired, but we keep in our database
# for the benefit of those users who completed FL courses before 1st April 2023

cs_accelerator = Programme.cs_accelerator
primary_certificate = Programme.primary_certificate
secondary_certificate = Programme.secondary_certificate

a = Activity.find_or_create_by(future_learn_course_uuid: "ecf78d20-2966-4798-af5f-0f869c1818e2") do |activity|
  activity.title = "Teaching Physical Computing with Raspberry Pi and Python"
  activity.credit = 20
  activity.slug = "teaching-physical-computing-with-raspberry-pi-and-python"
  activity.category = "online"
  activity.stem_course_template_no = "4936bd68-49b1-4e2c-b83f-5ea54db7e294"
  activity.future_learn_course_uuid = "ecf78d20-2966-4798-af5f-0f869c1818e2"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO205R"
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)
a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "c88099c0-8b44-42a5-aad3-0dd011fe3490") do |activity|
  activity.title = "How Computers Work: Demystifying Computation"
  activity.credit = 20
  activity.slug = "how-computers-work-demystifying-computation"
  activity.category = "online"
  activity.stem_course_template_no = "0fb20a94-d986-4844-a765-3f0eba96f11d"
  activity.future_learn_course_uuid = "c88099c0-8b44-42a5-aad3-0dd011fe3490"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO206R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "c9fb59cc-6393-4a29-8136-7020128ca879") do |activity|
  activity.title = "Programming 101: An Introduction to Python for Educators"
  activity.credit = 20
  activity.slug = "programming-101-an-introduction-to-python-for-educators"
  activity.category = "online"
  activity.stem_course_template_no = "90313f27-1af1-49c4-a1ed-aa5ebf755fd0"
  activity.future_learn_course_uuid = "c9fb59cc-6393-4a29-8136-7020128ca879"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO207R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)
a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "d9fe6126-298f-48ed-8be3-b82e1c473566") do |activity|
  activity.title = "Programming 102: Think like a Computer Scientist"
  activity.credit = 20
  activity.slug = "programming-102-think-like-a-computer-scientist"
  activity.category = "online"
  activity.stem_course_template_no = "c010fde0-2010-4b48-b7e2-67a5f667b538"
  activity.future_learn_course_uuid = "d9fe6126-298f-48ed-8be3-b82e1c473566"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO208R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "e290318f-ba23-4c95-8f18-584946233af9") do |activity|
  activity.title = "Representing Data with Images and Sound: Bringing Data to Life"
  activity.credit = 20
  activity.slug = "representing-data-with-images-and-sound-bringing-data-to-life"
  activity.category = "online"
  activity.stem_course_template_no = "7ec0f376-5c2f-4e20-a94e-2b56fd852275"
  activity.future_learn_course_uuid = "e290318f-ba23-4c95-8f18-584946233af9"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO209R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "2e1e3f69-b200-4fc7-a6bd-dff682bdd228") do |activity|
  activity.title = "Object-oriented Programming in Python: Create Your Own Adventure Game"
  activity.credit = 20
  activity.slug = "object-oriented-programming-in-python-create-your-own-adventure-game"
  activity.category = "online"
  activity.stem_course_template_no = "7da9e258-f029-45b2-b57d-e0bbc9574d5f"
  activity.future_learn_course_uuid = "2e1e3f69-b200-4fc7-a6bd-dff682bdd228"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO210R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "6c5bddfb-7dd4-467b-9554-34f3aedc233f") do |activity|
  activity.title = "An Introduction to Computer Networking for Teachers"
  activity.credit = 20
  activity.slug = "an-introduction-to-computer-networking-for-teachers"
  activity.category = "online"
  activity.stem_course_template_no = "579e53d8-f84c-45bd-9192-c6e4db5a5909"
  activity.future_learn_course_uuid = "6c5bddfb-7dd4-467b-9554-34f3aedc233f"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO214R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "ffc6793d-5643-40c8-893a-0164844ca62f") do |activity|
  activity.title = "Understanding Maths and Logic in Computer Science"
  activity.credit = 20
  activity.slug = "understanding-maths-and-logic-in-computer-science"
  activity.category = "online"
  activity.stem_course_template_no = "890c180c-2a32-464b-8d9d-b56d94e26515"
  activity.future_learn_course_uuid = "ffc6793d-5643-40c8-893a-0164844ca62f"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO213R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "04953102-a4cf-485d-a34e-0c64621033be") do |activity|
  activity.title = "Understanding Computer Systems"
  activity.credit = 20
  activity.slug = "understanding-computer-systems"
  activity.category = "online"
  activity.stem_course_template_no = "37df9a75-3938-4b36-a8e3-44825a72e5ea"
  activity.future_learn_course_uuid = "04953102-a4cf-485d-a34e-0c64621033be"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO212R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "4ec560a3-6435-46bc-90b7-75cfdcf7e72d") do |activity|
  activity.title = "Teaching Programming in Primary Schools"
  activity.credit = 10
  activity.slug = "teaching-programming-in-primary-schools"
  activity.category = "online"
  activity.stem_course_template_no = "497f57fd-bfaa-4b32-99b9-04f83805eb4c"
  activity.future_learn_course_uuid = "4ec560a3-6435-46bc-90b7-75cfdcf7e72d"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO010R"
  activity.always_on = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "3ce9a624-6cc7-4d23-8f5f-95162e360178") do |activity|
  activity.title = "Scratch to Python: Moving from Block- to Text-based Programming"
  activity.credit = 10
  activity.slug = "scratch-to-python-moving-from-block-to-text-based-programming"
  activity.category = "online"
  activity.stem_course_template_no = "6ef0e050-e94e-465e-8e70-5fa723517b10"
  activity.future_learn_course_uuid = "3ce9a624-6cc7-4d23-8f5f-95162e360178"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO211R"
  activity.always_on = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)
a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "e4115d3c-53d0-4538-94c2-e2a9ba366178") do |activity|
  activity.title = "Impact of Technology: How To Lead Classroom Discussions"
  activity.credit = 20
  activity.slug = "impact-of-technology-how-to-lead-classroom-discussions"
  activity.category = "online"
  activity.stem_course_template_no = "751bcaee-6b74-41e8-9a90-fcb52a1c234a"
  activity.future_learn_course_uuid = "e4115d3c-53d0-4538-94c2-e2a9ba366178"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO215R"
  activity.always_on = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)
a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "030261f8-1e96-4a70-a329-e3eb8b868915") do |activity|
  activity.title = "Introduction to Cybersecurity for Teachers"
  activity.credit = 20
  activity.slug = "introduction-to-cybersecurity-for-teachers"
  activity.category = "online"
  activity.stem_course_template_no = "004e04d9-5018-4a27-9c8d-8be1956bff0e"
  activity.future_learn_course_uuid = "030261f8-1e96-4a70-a329-e3eb8b868915"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO216R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "645ec51f-0b46-4102-a364-90647057f4f2") do |activity|
  activity.title = "Programming with GUIs"
  activity.credit = 20
  activity.slug = "programming-with-guis"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "91b14b5f-ba21-49c2-9393-14ac98e38dc7"
  activity.future_learn_course_uuid = "645ec51f-0b46-4102-a364-90647057f4f2"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO217R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "b19646a7-d78b-4a92-ad36-d4b3a11a3df1") do |activity|
  activity.title = "Creating an Inclusive Classroom: Approaches to Supporting Learners with SEND in Computing"
  activity.credit = 20
  activity.slug = "creating-an-inclusive-classroom-approaches-to-supporting-learners-with-send-in-computing"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "1296f189-6204-ea11-a811-000d3a86d716"
  activity.future_learn_course_uuid = "b19646a7-d78b-4a92-ad36-d4b3a11a3df1"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO700R"
  activity.always_on = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)
a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "83c939cf-8aa7-43d9-ad06-acaa3b859d91") do |activity|
  activity.title = "Design and Prototype Embedded Computer Systems"
  activity.credit = 20
  activity.slug = "design-and-prototype-embedded-computer-systems"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "5c75d757-e2f4-e911-a813-000d3a86d545"
  activity.future_learn_course_uuid = "83c939cf-8aa7-43d9-ad06-acaa3b859d91"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO218R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "66ceead6-5641-485c-9d10-40a35b8e465e") do |activity|
  activity.title = "Programming 103: Saving and Structuring Data"
  activity.credit = 20
  activity.slug = "programming-103-saving-and-structuring-data"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "d484d9e4-74f5-e911-a813-000d3a86d545"
  activity.future_learn_course_uuid = "66ceead6-5641-485c-9d10-40a35b8e465e"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO219R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "26e9cd23-2d71-4964-9af3-751aa3fdc8e5") do |activity|
  activity.title = "Programming Pedagogy in Primary Schools: Developing Computing Teaching"
  activity.credit = 20
  activity.slug = "programming-pedagogy-in-primary-schools-developing-computing-teaching"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "0d5092b4-6e04-ea11-a811-000d3a86d716"
  activity.future_learn_course_uuid = "26e9cd23-2d71-4964-9af3-751aa3fdc8e5"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO020R"
  activity.always_on = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "a1520b0c-8c99-49e5-8c65-f025f3431ab0") do |activity|
  activity.title = "Introduction to Encryption and Cryptography"
  activity.credit = 20
  activity.slug = "introduction-to-encryption-and-cryptography"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "f81891d3-d106-ea11-a811-000d3a86d6ba"
  activity.future_learn_course_uuid = "a1520b0c-8c99-49e5-8c65-f025f3431ab0"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO220R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "3574403e-a63f-4230-9f4b-3f5b6cd4ddb7") do |activity|
  activity.title = "Introduction to Web Development"
  activity.credit = 20
  activity.slug = "introduction-to-web-development"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "729c992c-8925-ea11-a810-000d3a86d7a3"
  activity.future_learn_course_uuid = "3574403e-a63f-4230-9f4b-3f5b6cd4ddb7"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO221R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "ceb5e1b6-6f1d-4e53-9cd3-3fddb2509fa8") do |activity|
  activity.title = "Networking with Python: Socket Programming for Communication"
  activity.credit = 20
  activity.slug = "networking-with-python-socket-programming-for-communication"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "af6b9355-0e39-ea11-a813-000d3a86d7a3"
  activity.future_learn_course_uuid = "ceb5e1b6-6f1d-4e53-9cd3-3fddb2509fa8"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO223R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "0adab04d-f1b5-4110-839d-76f9faf7b819") do |activity|
  activity.title = "Robotics With Raspberry Pi: Build and Program Your First Robot Buggy"
  activity.credit = 20
  activity.slug = "robotics-with-raspberry-pi-build-and-program-your-first-robot-buggy"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "ed1e2f83-655c-ea11-a811-000d3a86d7a3"
  activity.future_learn_course_uuid = "0adab04d-f1b5-4110-839d-76f9faf7b819"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO224R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "88ad7443-d27a-482c-b2a9-83ddc1357532") do |activity|
  activity.title = "Introduction to Databases and SQL"
  activity.credit = 20
  activity.slug = "introduction-to-databases-and-sql"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "bf13c4a5-ef7f-ea11-a811-000d3a86f6ce"
  activity.future_learn_course_uuid = "88ad7443-d27a-482c-b2a9-83ddc1357532"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO225R"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(future_learn_course_uuid: "7e5ae100-f4fc-425b-a53b-c81cb6eb4abc") do |activity|
  activity.title = "Improving Computing Classroom Practice Through Action Research"
  activity.credit = 20
  activity.slug = "improving-computing-classroom-practice-through-action-research"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "2d32d88c-35a7-ea11-a812-000d3a86d545"
  activity.future_learn_course_uuid = "7e5ae100-f4fc-425b-a53b-c81cb6eb4abc"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO030R"
  activity.always_on = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)
a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "bc7debb8-59a0-4d4a-8d86-082047bf155f") do |activity|
  activity.title = "Get Started Teaching Computing in Primary Schools: Preparing to teach 5 - 11 year olds"
  activity.credit = 20
  activity.slug = "get-started-teaching-computing-in-primary-schools-preparing-to-teach-5-11-year-olds"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "20cbed18-e966-eb11-a812-0022481a5e0d"
  activity.future_learn_course_uuid = "bc7debb8-59a0-4d4a-8d86-082047bf155f"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO040R"
  activity.always_on = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "8a38adaf-9a03-414a-ad9f-c0b5a9f347f1") do |activity|
  activity.title = "Teach Computing in Schools: Creating a Curriculum for Ages 11 to 16"
  activity.credit = 20
  activity.slug = "teach-computing-in-schools-creating-a-curriculum-for-ages-11-to-16"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "6f127935-ab72-eb11-a812-0022481a6e92"
  activity.future_learn_course_uuid = "8a38adaf-9a03-414a-ad9f-c0b5a9f347f1"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO230R"
  activity.always_on = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "147b3adf-9f26-4ffa-a95f-6c1720ca4d27") do |activity|
  activity.title = "Teaching Programming to 5 - 11 year olds"
  activity.credit = 10
  activity.slug = "teaching-programming-to-5-11-year-olds"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "06bb0045-bb8b-eb11-b1ac-0022481a67ae"
  activity.future_learn_course_uuid = "147b3adf-9f26-4ffa-a95f-6c1720ca4d27"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO041R"
  activity.always_on = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "7f88c178-9538-4970-b438-ab80e6125d5e") do |activity|
  activity.title = "Teaching Computing Systems and Networks to 5- to 11-year-olds"
  activity.credit = 10
  activity.slug = "teaching-computing-systems-and-networks-to-5-to-11-year-olds"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "31971bdc-34d0-eb11-bacc-00224800f845"
  activity.future_learn_course_uuid = "7f88c178-9538-4970-b438-ab80e6125d5e"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO042R"
  activity.always_on = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "d440d652-4128-4995-9ef7-662a0bc505ed") do |activity|
  activity.title = "Teaching Physical Computing to 5-11 year olds"
  activity.credit = 10
  activity.slug = "teaching-physical-computing-to-5-11-year-olds"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "030b2253-40ff-eb11-94ef-0022481b4787"
  activity.future_learn_course_uuid = "d440d652-4128-4995-9ef7-662a0bc505ed"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO043R"
  activity.always_on = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "0fbfa644-501d-4ac0-b3ef-3cc458d33527") do |activity|
  activity.title = "Introduction to Machine Learning and AI"
  activity.credit = 20
  activity.slug = "introduction-to-machine-learning-and-ai"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "a3fd8b2e-c516-ec11-b6e6-0022481a4e89"
  activity.future_learn_course_uuid = "0fbfa644-501d-4ac0-b3ef-3cc458d33527"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO231R"
  activity.always_on = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "b2445d09-f3b3-45da-b4ec-6d33bb6cb89b") do |activity|
  activity.title = "Teaching Data and Information to 5 - 11 Year Olds"
  activity.credit = 10
  activity.slug = "teaching-data-and-information-to-5-11-year-olds"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "7ee623a1-f02f-ec11-b6e6-000d3a871bbc"
  activity.future_learn_course_uuid = "b2445d09-f3b3-45da-b4ec-6d33bb6cb89b"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO044R"
  activity.always_on = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "56c90f6c-c741-4796-88d1-549c0d625ca7") do |activity|
  activity.title = "Introduction to Programming with Scratch"
  activity.credit = 20
  activity.slug = "introduction-to-programming-with-scratch"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "f8f2b9d3-5483-ec11-8d21-0022481b4871"
  activity.future_learn_course_uuid = "56c90f6c-c741-4796-88d1-549c0d625ca7"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO232R"
  activity.always_on = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(future_learn_course_uuid: "6cd40c14-adbf-4da7-af81-849d0f74a2fe") do |activity|
  activity.title = "Programming Pedagogy in Secondary Schools: Inspiring Computing Teaching"
  activity.credit = 20
  activity.slug = "programming-pedagogy-in-secondary-schools-inspiring-computing-teaching"
  activity.category = "online"
  activity.self_certifiable = false
  activity.stem_course_template_no = "50c5bbf7-8f25-ea11-a810-000d3a86d7a3"
  activity.future_learn_course_uuid = "6cd40c14-adbf-4da7-af81-849d0f74a2fe"
  activity.provider = "future-learn"
  activity.stem_activity_code = "CO222R"
  activity.always_on = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)
