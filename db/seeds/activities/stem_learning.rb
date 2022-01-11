# This file contains seeds for Activities faciliated by STEM Learning

cs_accelerator = Programme.cs_accelerator
primary_certificate = Programme.primary_certificate
secondary_certificate = Programme.secondary_certificate

a = Activity.find_or_create_by(stem_course_template_no: 'a6b10502-6788-4ebc-b465-41eafb1e2a18') do |activity|
  activity.title = 'Algorithms in GCSE computer science'
  activity.credit = 20
  activity.slug = 'algorithms-in-gcse-computer-science'
  activity.stem_course_template_no = 'a6b10502-6788-4ebc-b465-41eafb1e2a18'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '7159562d-4b1a-44f3-b4d7-3e677b9898f2') do |activity|
  activity.title = 'Data and computer systems in GCSE computer science'
  activity.credit = 20
  activity.slug = 'data-and-computer-systems-in-gcse-computer-science'
  activity.stem_course_template_no = '7159562d-4b1a-44f3-b4d7-3e677b9898f2'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'ec9bf026-49da-4542-abb9-2551f862d8d5') do |activity|
  activity.title = 'NCCE facilitator development program (stage one)'
  activity.credit = 40
  activity.slug = 'ncce-facilitator-development-program-stage-one'
  activity.stem_course_template_no = 'ec9bf026-49da-4542-abb9-2551f862d8d5'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '88715914-72ee-4b26-a22b-4f2d610ed267') do |activity|
  activity.title = 'NCCE Train the Trainer'
  activity.credit = 0
  activity.slug = 'ncce-train-the-trainer'
  activity.stem_course_template_no = '88715914-72ee-4b26-a22b-4f2d610ed267'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

a = Activity.find_or_create_by(stem_course_template_no: '0650b45c-e4b3-4c8b-bd90-7a1428fe2986') do |activity|
  activity.title = 'Networks and Cyber Security in GCSE computer science'
  activity.credit = 20
  activity.slug = 'networks-and-cyber-security-in-gcse-computer-science'
  activity.stem_course_template_no = '0650b45c-e4b3-4c8b-bd90-7a1428fe2986'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '488bed9b-515b-4295-a488-62b5bb6bf852') do |activity|
  activity.title = 'Teaching and leading key stage 1 computing'
  activity.credit = 40
  activity.slug = 'teaching-and-leading-key-stage-1-computing'
  activity.stem_course_template_no = '488bed9b-515b-4295-a488-62b5bb6bf852'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP001'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '16aeecbd-d202-4f42-bad3-f86c8f671547') do |activity|
  activity.title = 'Teaching and leading key stage 2 computing'
  activity.credit = 40
  activity.slug = 'teaching-and-leading-key-stage-2-computing'
  activity.stem_course_template_no = '16aeecbd-d202-4f42-bad3-f86c8f671547'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP002'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '68f5b6c5-556d-4b66-8159-7cd6019da6f3') do |activity|
  activity.title = 'Primary programming and algorithms'
  activity.credit = 40
  activity.slug = 'primary-programming-and-algorithms'
  activity.stem_course_template_no = '68f5b6c5-556d-4b66-8159-7cd6019da6f3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP003'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '92f4f86e-0237-4ecc-a905-2f6c62d6b5ae') do |activity|
  activity.title = 'Python programming essentials for GCSE computer science'
  activity.credit = 20
  activity.slug = 'python-programming-essentials-for-gcse-computer-science'
  activity.stem_course_template_no = '92f4f86e-0237-4ecc-a905-2f6c62d6b5ae'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '26c20962-6279-4927-b797-42363848130c') do |activity|
  activity.title = 'Creative Computing for Key Stage 3'
  activity.credit = 0
  activity.slug = 'creative-computing-for-key-stage-3'
  activity.stem_course_template_no = '26c20962-6279-4927-b797-42363848130c'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '1dcba944-6ae9-4b68-af69-56df49495bd7') do |activity|
  activity.title = 'GCSE Computer Science - developing outstanding teaching'
  activity.credit = 0
  activity.slug = 'gcse-computer-science-developing-outstanding-teaching'
  activity.stem_course_template_no = '1dcba944-6ae9-4b68-af69-56df49495bd7'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '258c93cc-69e2-46f6-bf39-fbce27cb8fc2') do |activity|
  activity.title = 'KS4 computing for all'
  activity.credit = 0
  activity.slug = 'ks4-computing-for-all'
  activity.stem_course_template_no = '258c93cc-69e2-46f6-bf39-fbce27cb8fc2'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP207'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: 'f7fefbae-53aa-4c28-bbd2-b3d3b1bf7bbd') do |activity|
  activity.title = 'Pre January 2019 CSA Face to Face CPD'
  activity.credit = 40
  activity.slug = 'pre-january-2019-csa-face-to-face-cpd'
  activity.stem_course_template_no = 'f7fefbae-53aa-4c28-bbd2-b3d3b1bf7bbd'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '46c07f3e-b9b2-4f0c-ba56-52319aadb955') do |activity|
  activity.title = 'Key stage 3 computing for non-specialists'
  activity.credit = 0
  activity.slug = 'key-stage-3-computing-for-non-specialists'
  activity.stem_course_template_no = '46c07f3e-b9b2-4f0c-ba56-52319aadb955'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

a = Activity.find_or_create_by(stem_course_template_no: '87bf64c2-6517-ea11-a811-000d3a86d545') do |activity|
  activity.title = 'Introduction to GCSE computer science'
  activity.credit = 20
  activity.slug = 'introduction-to-gcse-computer-science'
  activity.stem_course_template_no = '87bf64c2-6517-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '0d64b3cd-b866-ea11-a811-000d3a86d7a3') do |activity|
  activity.title = 'Search and sort algorithms'
  activity.credit = 10
  activity.slug = 'search-and-sort-algorithms'
  activity.stem_course_template_no = '0d64b3cd-b866-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP220'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '1199992c-3665-ea11-a811-000d3a86d7a3') do |activity|
  activity.title = 'Representing algorithms using flowcharts and pseudocode'
  activity.credit = 10
  activity.slug = 'representing-algorithms-using-flowcharts-and-pseudocode'
  activity.stem_course_template_no = '1199992c-3665-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP230'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '80d93c0f-be66-ea11-a811-000d3a86d7a3') do |activity|
  activity.title = 'Computer systems: input, output and storage'
  activity.credit = 10
  activity.slug = 'computer-systems-input-output-and-storage'
  activity.stem_course_template_no = '80d93c0f-be66-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP221'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '94b15af9-c066-ea11-a811-000d3a86d7a3') do |activity|
  activity.title = 'Computer processors'
  activity.credit = 10
  activity.slug = 'computer-processors'
  activity.stem_course_template_no = '94b15af9-c066-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP231'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'ff9ee9a5-6267-ea11-a811-000d3a86d7a3') do |activity|
  activity.title = 'Fundamentals of computer networks'
  activity.credit = 10
  activity.slug = 'fundamentals-of-computer-networks'
  activity.stem_course_template_no = 'ff9ee9a5-6267-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP222'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '46d64f78-6367-ea11-a811-000d3a86d7a3') do |activity|
  activity.title = 'The internet and cyber-security'
  activity.credit = 10
  activity.slug = 'the-internet-and-cyber-security'
  activity.stem_course_template_no = '46d64f78-6367-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP232'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '43476cb7-6567-ea11-a811-000d3a86d7a3') do |activity|
  activity.title = 'Python programming constructs: sequencing, selection, iteration'
  activity.credit = 10
  activity.slug = 'python-programming-constructs-sequencing-selection-iteration'
  activity.stem_course_template_no = '43476cb7-6567-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP223'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '84568ccf-6767-ea11-a811-000d3a86d7a3') do |activity|
  activity.title = 'Python programming: working with data'
  activity.credit = 10
  activity.slug = 'python-programming-working-with-data'
  activity.stem_course_template_no = '84568ccf-6767-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP233'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'de08c1a9-3868-ea11-a811-000d3a86d7a3') do |activity|
  activity.title = 'An introduction to algorithms, programming and data in GCSE Computer Science'
  activity.credit = 10
  activity.slug = 'an-introduction-to-algorithms-programming-and-data-in-gcse-computer-science'
  activity.stem_course_template_no = 'de08c1a9-3868-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP228'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '17d78590-4268-ea11-a811-000d3a86d7a3') do |activity|
  activity.title = 'An introduction to computer systems, networking and security in GCSE computer science'
  activity.credit = 10
  activity.slug = 'an-introduction-to-computer-systems-networking-and-security-in-gcse-computer-science'
  activity.stem_course_template_no = '17d78590-4268-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP238'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '07e76ffd-e17f-ea11-a811-000d3a86f6ce') do |activity|
  activity.title = 'Representing algorithms using flowcharts and pseudocode'
  activity.credit = 10
  activity.slug = 'representing-algorithms-using-flowcharts-and-pseudocode-remote'
  activity.stem_course_template_no = '07e76ffd-e17f-ea11-a811-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP420'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'dd8a8433-e57f-ea11-a811-000d3a86f6ce') do |activity|
  activity.title = 'Fundamentals of Computer Networks'
  activity.credit = 10
  activity.slug = 'fundamentals-of-computer-networks-remote'
  activity.stem_course_template_no = 'dd8a8433-e57f-ea11-a811-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP422'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '935a0639-e87f-ea11-a811-000d3a86f6ce') do |activity|
  activity.title = 'Python programming constructs: sequencing, selection & iteration'
  activity.credit = 10
  activity.slug = 'python-programming-constructs-sequencing-selection-iteration-remote'
  activity.stem_course_template_no = '935a0639-e87f-ea11-a811-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP423'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'e432e725-ba7f-ea11-a811-000d3a86d545') do |activity|
  activity.title = 'Teaching and leading key stage 1 computing - Module 1'
  activity.credit = 10
  activity.slug = 'teaching-and-leading-key-stage-1-computing-module-1'
  activity.stem_course_template_no = 'e432e725-ba7f-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP450'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '5b694e80-ce7f-ea11-a811-000d3a86d545') do |activity|
  activity.title = 'Teaching and leading key stage 1 computing - Module 2'
  activity.credit = 10
  activity.slug = 'teaching-and-leading-key-stage-1-computing-module-2'
  activity.stem_course_template_no = '5b694e80-ce7f-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP451'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: 'a533bf46-d17f-ea11-a811-000d3a86d545') do |activity|
  activity.title = 'Teaching and leading key stage 2 computing - Module 1'
  activity.credit = 10
  activity.slug = 'teaching-and-leading-key-stage-2-computing-module-1'
  activity.stem_course_template_no = 'a533bf46-d17f-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP452'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '5fdb7188-dd7f-ea11-a811-000d3a86f6ce') do |activity|
  activity.title = 'Teaching and leading key stage 2 computing - Module 2'
  activity.credit = 10
  activity.slug = 'teaching-and-leading-key-stage-2-computing-module-2'
  activity.stem_course_template_no = '5fdb7188-dd7f-ea11-a811-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP453'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '526b3a42-b688-ea11-a811-000d3a86d545') do |activity|
  activity.title = 'Introduction to algorithms, programming and data in GCSE computer science'
  activity.credit = 10
  activity.slug = 'introduction-to-algorithms-programming-and-data-in-gcse-computer-science-remote'
  activity.stem_course_template_no = '526b3a42-b688-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP428'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '65fe83ad-b188-ea11-a811-000d3a86d545') do |activity|
  activity.title = 'Computer processors'
  activity.credit = 10
  activity.slug = 'computer-processors-remote'
  activity.stem_course_template_no = '65fe83ad-b188-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP431'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '770d8136-3d86-ea11-a811-000d3a86d545') do |activity|
  activity.title = 'The Internet and Cyber Security'
  activity.credit = 10
  activity.slug = 'the-internet-and-cyber-security-remote'
  activity.stem_course_template_no = '770d8136-3d86-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP432'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '67a21143-4886-ea11-a811-000d3a86d545') do |activity|
  activity.title = 'Python programming: working with data'
  activity.credit = 10
  activity.slug = 'python-programming-working-with-data-remote'
  activity.stem_course_template_no = '67a21143-4886-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP433'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'bd6497ad-4386-ea11-a811-000d3a86d545') do |activity|
  activity.title = 'An introduction to computer systems, networking and security in GCSE computer science'
  activity.credit = 10
  activity.slug = 'an-introduction-to-computer-systems-networking-and-security-in-gcse-computer-science-remote'
  activity.stem_course_template_no = 'bd6497ad-4386-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP438'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'dbb7808c-b888-ea11-a811-000d3a86d545') do |activity|
  activity.title = 'Key Stage 3 computing for the non-specialist teacher'
  activity.credit = 10
  activity.slug = 'key-stage-3-computing-for-the-non-specialist-teacher-remote'
  activity.stem_course_template_no = 'dbb7808c-b888-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP445'
end

a = Activity.find_or_create_by(stem_course_template_no: 'e5acc943-4926-ea11-a810-000d3a86d545') do |activity|
  activity.title = 'Introduction to primary computing'
  activity.credit = 10
  activity.slug = 'introduction-to-primary-computing'
  activity.stem_course_template_no = 'e5acc943-4926-ea11-a810-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP004'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: 'bb7a0f31-5086-ea11-a811-000d3a86d545') do |activity|
  activity.title = 'Introduction to primary computing'
  activity.credit = 10
  activity.slug = 'introduction-to-primary-computing-remote'
  activity.stem_course_template_no = 'bb7a0f31-5086-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP454'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '6bc40e34-4c86-ea11-a811-000d3a86d545') do |activity|
  activity.title = 'Primary programming and algorithms'
  activity.credit = 10
  activity.slug = 'primary-programming-and-algorithms-remote'
  activity.stem_course_template_no = '6bc40e34-4c86-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP455'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '41a77207-c4c2-ea11-a812-000d3a86d545') do |activity|
  activity.title = 'Higher attainment in GCSE computer science - meeting the challenge of exams'
  activity.credit = 10
  activity.slug = 'higher-attainment-in-gcse-computer-science-meeting-the-challenge-of-exams'
  activity.stem_course_template_no = '41a77207-c4c2-ea11-a812-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP239'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '22880db7-78e8-ea11-a817-000d3a86f6ce') do |activity|
  activity.title = 'New subject leaders of secondary computing'
  activity.credit = 10
  activity.slug = 'new-subject-leaders-of-secondary-computing'
  activity.stem_course_template_no = '22880db7-78e8-ea11-a817-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP211'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '6ed470e0-75e8-ea11-a817-000d3a86f6ce') do |activity|
  activity.title = 'Key Stage 3 computing for the non-specialist teacher'
  activity.credit = 10
  activity.slug = 'key-stage-3-computing-for-the-non-specialist-teacher'
  activity.stem_course_template_no = '6ed470e0-75e8-ea11-a817-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP215'
end

a = Activity.find_or_create_by(stem_course_template_no: 'd0aa3d40-f2f7-ea11-a815-000d3a86f6ce') do |activity|
  activity.title = 'Python programming projects - advanced subject knowledge, implementation and testing a programme'
  activity.credit = 10
  activity.slug = 'python-programming-projects-advanced-subject-knowledge-implementation-and-testing-a-programme'
  activity.stem_course_template_no = 'd0aa3d40-f2f7-ea11-a815-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP243'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'de4d357a-93f9-ea11-a815-000d3a86f6ce') do |activity|
  activity.title = 'Python programming projects: analysis, design and evaluation'
  activity.credit = 10
  activity.slug = 'python-programming-projects-analysis-design-and-evaluation'
  activity.stem_course_template_no = 'de4d357a-93f9-ea11-a815-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP244'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '34ff2768-a7fc-ea11-a813-000d3a86d545') do |activity|
  activity.title = 'Outstanding primary computing for all - face to face'
  activity.credit = 10
  activity.slug = 'outstanding-primary-computing-for-all-face-to-face'
  activity.stem_course_template_no = '34ff2768-a7fc-ea11-a813-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP005'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: 'e3c14378-3015-eb11-a813-000d3a86f6ce') do |activity|
  activity.title = 'Leading Primary Computing - Face to Face'
  activity.credit = 10
  activity.slug = 'leading-primary-computing-face-to-face'
  activity.stem_course_template_no = 'e3c14378-3015-eb11-a813-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP008'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '03fb0a52-a712-eb11-a813-000d3a86d545') do |activity|
  activity.title = 'Higher attainment in GCSE computer science - meeting the challenge of exams'
  activity.credit = 10
  activity.slug = 'higher-attainment-in-gcse-computer-science-meeting-the-challenge-of-exams-remote'
  activity.stem_course_template_no = '03fb0a52-a712-eb11-a813-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP439'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'e1e54959-db12-eb11-a813-000d3a86d545') do |activity|
  activity.title = 'Python programming projects - advanced subject knowledge, implementation and testing a program - Remote'
  activity.credit = 10
  activity.slug = 'python-programming-projects-advanced-subject-knowledge-implementation-and-testing-a-program-remote'
  activity.stem_course_template_no = 'e1e54959-db12-eb11-a813-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP463'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'ce24e77f-d312-eb11-a813-000d3a86f6ce') do |activity|
  activity.title = 'Search and sort algorithms - Remote'
  activity.credit = 10
  activity.slug = 'search-and-sort-algorithms-remote'
  activity.stem_course_template_no = 'ce24e77f-d312-eb11-a813-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP430'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '8eb6f3de-bf12-eb11-a813-000d3a86d545') do |activity|
  activity.title = 'Computer systems, Input, output and storage - Remote'
  activity.credit = 10
  activity.slug = 'computer-systems-input-output-and-storage-remote'
  activity.stem_course_template_no = '8eb6f3de-bf12-eb11-a813-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP421'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'ad8580c0-2915-eb11-a813-000d3a86f6ce') do |activity|
  activity.title = 'Python programming projects - analysing, designing and evaluating a program - Remote'
  activity.credit = 10
  activity.slug = 'python-programming-projects-analysing-designing-and-evaluating-a-program-remote'
  activity.stem_course_template_no = 'ad8580c0-2915-eb11-a813-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP464'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '952bb189-4239-eb11-a813-000d3a86d545') do |activity|
  activity.title = 'An introduction to teaching robotics using VEXcode VR'
  activity.credit = 0
  activity.slug = 'an-introduction-to-teaching-robotics-using-vexcode-vr'
  activity.stem_course_template_no = '952bb189-4239-eb11-a813-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP301'
end

a = Activity.find_or_create_by(stem_course_template_no: '67ff4e64-d83a-eb11-a813-000d3a86d545') do |activity|
  activity.title = 'Introduction to algorithms, programming and data for D&T teachers'
  activity.credit = 10
  activity.slug = 'introduction-to-algorithms-programming-and-data-for-d-t-teachers-remote'
  activity.stem_course_template_no = '67ff4e64-d83a-eb11-a813-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP429'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'c0b37384-e93a-eb11-a813-000d3a86d545') do |activity|
  activity.title = 'Introduction to algorithms, programming and data for D&T teachers'
  activity.credit = 10
  activity.slug = 'introduction-to-algorithms-programming-and-data-for-d-t-teachers-face-to-face'
  activity.stem_course_template_no = 'c0b37384-e93a-eb11-a813-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP229'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'f12d0fbd-993b-eb11-a813-000d3a86d545') do |activity|
  activity.title = 'Enriching secondary computing with STEM Ambassadors'
  activity.credit = 10
  activity.slug = 'enriching-secondary-computing-with-stem-ambassadors'
  activity.stem_course_template_no = 'f12d0fbd-993b-eb11-a813-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP446'
end

a = Activity.find_or_create_by(stem_course_template_no: '11f58c3f-3341-eb11-a813-000d3a86d545') do |activity|
  activity.title = 'Assessment of primary computing'
  activity.credit = 20
  activity.slug = 'assessment-of-primary-computing'
  activity.stem_course_template_no = '11f58c3f-3341-eb11-a813-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP007'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '3b2957a3-3541-eb11-a813-000d3a86d545') do |activity|
  activity.title = 'KS3 computing (module 1): Creative curriculum design principles'
  activity.credit = 10
  activity.slug = 'ks3-computing-module-1-creative-curriculum-design-principles'
  activity.stem_course_template_no = '3b2957a3-3541-eb11-a813-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP247'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: 'c9957d36-3841-eb11-a813-000d3a86d545') do |activity|
  activity.title = 'KS3 computing (module 2): Creative curriculum content, sequencing and pedagogy'
  activity.credit = 10
  activity.slug = 'ks3-computing-module-2-creative-curriculum-content-sequencing-and-pedagogy'
  activity.stem_course_template_no = 'c9957d36-3841-eb11-a813-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP248'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '15040292-3941-eb11-a813-000d3a86d545') do |activity|
  activity.title = 'KS3 computing (module 3): Creative curriculum enrichment and inclusion'
  activity.credit = 10
  activity.slug = 'ks3-computing-module-3-creative-curriculum-enrichment-and-inclusion'
  activity.stem_course_template_no = '15040292-3941-eb11-a813-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP249'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '6e8bfcd4-df50-eb11-a812-000d3a86f6ce') do |activity|
  activity.title = 'Teaching GCSE Computer Science: improving student engagement'
  activity.credit = 10
  activity.slug = 'teaching-gcse-computer-science-improving-student-engagement-remote'
  activity.stem_course_template_no = '6e8bfcd4-df50-eb11-a812-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP447'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '1a81f632-a255-eb11-a812-000d3a874628') do |activity|
  activity.title = 'Teaching GCSE computer science: improving student engagement'
  activity.credit = 10
  activity.slug = 'teaching-gcse-computer-science-improving-student-engagement'
  activity.stem_course_template_no = '1a81f632-a255-eb11-a812-000d3a874628'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP240'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '7ab53294-7a6c-eb11-a812-000d3a872800') do |activity|
  activity.title = 'Computing as a second subject for non-specialist teachers'
  activity.credit = 10
  activity.slug = 'computing-as-a-second-subject-for-non-specialist-teachers'
  activity.stem_course_template_no = '7ab53294-7a6c-eb11-a812-000d3a872800'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP308'
end

a = Activity.find_or_create_by(stem_course_template_no: '5b1b5967-7c6c-eb11-a812-000d3a872800') do |activity|
  activity.title = 'New subject leaders of secondary computing (remote)'
  activity.credit = 10
  activity.slug = 'new-subject-leaders-of-secondary-computing-remote'
  activity.stem_course_template_no = '5b1b5967-7c6c-eb11-a812-000d3a872800'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP411'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '3bff03fd-256d-eb11-a812-000d3a872640') do |activity|
  activity.title = 'Leading primary computing (remote)'
  activity.credit = 10
  activity.slug = 'leading-primary-computing-remote'
  activity.stem_course_template_no = '3bff03fd-256d-eb11-a812-000d3a872640'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP456'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '1b0d5b9c-c97d-eb11-a812-0022481a889a') do |activity|
  activity.title = 'New to computing pathway for humanities and PSHE teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-humanities-and-pshe-teachers'
  activity.stem_course_template_no = '1b0d5b9c-c97d-eb11-a812-0022481a889a'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP472'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'baa34bc0-ca7d-eb11-a812-0022481a889a') do |activity|
  activity.title = 'New to computing pathway for music, art and media teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-music-art-and-media-teachers'
  activity.stem_course_template_no = 'baa34bc0-ca7d-eb11-a812-0022481a889a'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP473'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'f1ae2e7d-f37f-eb11-a812-000d3a8743ca') do |activity|
  activity.title = 'New to computing pathway for modern foreign language teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-modern-foreign-language-teachers'
  activity.stem_course_template_no = 'f1ae2e7d-f37f-eb11-a812-000d3a8743ca'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP474'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '2518b7bc-fb7f-eb11-a812-000d3a8743ca') do |activity|
  activity.title = 'New to computing pathway for English teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-english-teachers'
  activity.stem_course_template_no = '2518b7bc-fb7f-eb11-a812-000d3a8743ca'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP475'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '05854aa2-fd7f-eb11-a812-000d3a8743ca') do |activity|
  activity.title = 'New to computing pathway for Science teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-science-teachers'
  activity.stem_course_template_no = '05854aa2-fd7f-eb11-a812-000d3a8743ca'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP476'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '08fc66c2-6686-eb11-a812-0022481a795f') do |activity|
  activity.title = 'New to computing pathway for business teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-business-teachers-face-to-face'
  activity.stem_course_template_no = '08fc66c2-6686-eb11-a812-0022481a795f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP270'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '683eca82-6a86-eb11-a812-0022481a795f') do |activity|
  activity.title = 'New to computing pathway for PE teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-pe-teachers-face-to-face'
  activity.stem_course_template_no = '683eca82-6a86-eb11-a812-0022481a795f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP271'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '023164c4-6d86-eb11-a812-0022481a795f') do |activity|
  activity.title = 'New to computing pathway for humanities and PSHE teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-humanities-and-pshe-teachers-face-to-face'
  activity.stem_course_template_no = '023164c4-6d86-eb11-a812-0022481a795f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP272'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '100969a4-6f86-eb11-a812-0022481a795f') do |activity|
  activity.title = ' New to computing pathway for music, art and media teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-music-art-and-media-teachers-face-to-face'
  activity.stem_course_template_no = '100969a4-6f86-eb11-a812-0022481a795f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP273'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '39b94bd0-7186-eb11-a812-0022481a795f') do |activity|
  activity.title = 'New to computing pathway for modern foreign language teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-modern-foreign-language-teachers-face-to-face'
  activity.stem_course_template_no = '39b94bd0-7186-eb11-a812-0022481a795f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP274'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '75CAE0B0-7386-EB11-A812-0022481A795F') do |activity|
  activity.title = 'New to computing pathway for English teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-english-teachers-face-to-face'
  activity.stem_course_template_no = '75CAE0B0-7386-EB11-A812-0022481A795F'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP275'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'cb178ecb-7486-eb11-a812-0022481a795f') do |activity|
  activity.title = 'New to computing pathway for Science teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-science-teachers-face-to-face'
  activity.stem_course_template_no = 'cb178ecb-7486-eb11-a812-0022481a795f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP276'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'bacc4ebb-eb8a-eb11-b1ac-0022481a662d') do |activity|
  activity.title = 'Teaching GCSE Computer Science: developing knowledge and understanding'
  activity.credit = 10
  activity.slug = 'teaching-gcse-computer-science-developing-knowledge-and-understanding-face-to-face'
  activity.stem_course_template_no = 'bacc4ebb-eb8a-eb11-b1ac-0022481a662d'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP241'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: 'd35ce2c2-e78a-eb11-b1ac-0022481a662d') do |activity|
  activity.title = 'Teaching GCSE Computer Science pedagogy for programming'
  activity.credit = 10
  activity.slug = 'teaching-gcse-computer-science-pedagogy-for-programming-face-to-face'
  activity.stem_course_template_no = 'd35ce2c2-e78a-eb11-b1ac-0022481a662d'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP242'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '4044cbf0-776c-eb11-a812-000d3a872800') do |activity|
  activity.title = 'New to computing - Spring into the Computer Science Accelerator Easter 2021'
  activity.credit = 40
  activity.slug = 'new-to-computing-spring-into-the-computer-science-accelerator-easter-2021'
  activity.stem_course_template_no = '4044cbf0-776c-eb11-a812-000d3a872800'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP250'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '7f63e415-7a6c-eb11-a812-000d3a872800') do |activity|
  activity.title = 'Advanced GCSE Computer Science - Spring into the Computer Science Accelerator Easter 2021'
  activity.credit = 40
  activity.slug = 'advanced-gcse-computer-science-spring-into-the-computer-science-accelerator-easter-2021'
  activity.stem_course_template_no = '7f63e415-7a6c-eb11-a812-000d3a872800'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP251'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'be2eae05-828c-eb11-b1ac-0022481a6ad5') do |activity|
  activity.title = 'Collaboration in KS3 programming'
  activity.credit = 10
  activity.slug = 'collaboration-in-ks3-programming'
  activity.stem_course_template_no = 'be2eae05-828c-eb11-b1ac-0022481a6ad5'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP437'
  activity.remote_delivered_cpd = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '2c724a38-768d-eb11-b1ac-0022481a6ad5') do |activity|
  activity.title = 'New to computing pathway for Maths teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-maths-teachers'
  activity.stem_course_template_no = '2c724a38-768d-eb11-b1ac-0022481a6ad5'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP277'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '2ea1cee7-438d-eb11-b1ac-0022481a6ad5') do |activity|
  activity.title = 'Maths in computer science'
  activity.credit = 10
  activity.slug = 'maths-in-computer-science'
  activity.stem_course_template_no = '2ea1cee7-438d-eb11-b1ac-0022481a6ad5'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP234'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'b9af812f-4b8d-eb11-b1ac-0022481a6ad5') do |activity|
  activity.title = 'Assessment in secondary computing'
  activity.credit = 10
  activity.slug = 'assessment-in-secondary-computing'
  activity.stem_course_template_no = 'b9af812f-4b8d-eb11-b1ac-0022481a6ad5'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP413'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: 'afa28241-4d8d-eb11-b1ac-0022481a6ad5') do |activity|
  activity.title = 'Maths in computer science - remote'
  activity.credit = 10
  activity.slug = 'maths-in-computer-science-remote'
  activity.stem_course_template_no = 'afa28241-4d8d-eb11-b1ac-0022481a6ad5'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP434'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '22ee67ba-4f8d-eb11-b1ac-0022481a6ad5') do |activity|
  activity.title = 'Encouraging girls into GCSE computer science'
  activity.credit = 10
  activity.slug = 'encouraging-girls-into-gcse-computer-science'
  activity.stem_course_template_no = '22ee67ba-4f8d-eb11-b1ac-0022481a6ad5'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP440'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: '3fd9b792-af8c-eb11-b1ac-0022481a6ad5') do |activity|
  activity.title = 'New to computing pathway for Maths teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-maths-teachers-remote'
  activity.stem_course_template_no = '3fd9b792-af8c-eb11-b1ac-0022481a6ad5'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP477'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '039c98c5-3c91-eb11-b1ac-000d3a86ec4a') do |activity|
  activity.title = 'Careers and enrichment in primary computing with STEM Ambassadors in your region'
  activity.credit = 10
  activity.slug = 'careers-and-enrichment-in-primary-computing-with-stem-ambassadors-in-your-region'
  activity.stem_course_template_no = '039c98c5-3c91-eb11-b1ac-000d3a86ec4a'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP441'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: 'aafe379e-9e8c-eb11-b1ac-0022481a6ffe') do |activity|
  activity.title = 'KS3 computing (module 1): Creative curriculum design principles'
  activity.credit = 10
  activity.slug = 'ks3-computing-module-1-creative-curriculum-design-principles'
  activity.stem_course_template_no = 'aafe379e-9e8c-eb11-b1ac-0022481a6ffe'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP435'
  activity.remote_delivered_cpd = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '6172f084-b38c-eb11-b1ac-0022481a6ffe') do |activity|
  activity.title = 'Solving computational problems in KS3 computing'
  activity.credit = 10
  activity.slug = 'solving-computational-problems-in-ks3-computing'
  activity.stem_course_template_no = '6172f084-b38c-eb11-b1ac-0022481a6ffe'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP436'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '4a06856d-7977-eb11-a812-0022481a9648') do |activity|
  activity.title = 'New to computing pathway for Business teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-business-teachers-remote'
  activity.stem_course_template_no = '4a06856d-7977-eb11-a812-0022481a9648'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP470'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'e8c02102-7c77-eb11-a812-0022481a9648') do |activity|
  activity.title = 'New to computing pathway for PE teachers'
  activity.credit = 40
  activity.slug = 'new-to-computing-pathway-for-pe-teachers-remote'
  activity.stem_course_template_no = 'e8c02102-7c77-eb11-a812-0022481a9648'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP471'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'de77674a-51b2-eb11-8236-000d3a8747c3') do |activity|
  activity.title = 'Physical computing kit - KS2 Crumble'
  activity.credit = 10
  activity.slug = 'physical-computing-kit-ks2-crumble'
  activity.stem_course_template_no = 'de77674a-51b2-eb11-8236-000d3a8747c3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP252'
end

a = Activity.find_or_create_by(stem_course_template_no: '3e42eddb-54b2-eb11-8236-000d3a8747c3') do |activity|
  activity.title = 'Physical computing kit - KS4 Raspberry Pi Pico'
  activity.credit = 10
  activity.slug = 'physical-computing-kit-ks4-raspberry-pi-pico'
  activity.stem_course_template_no = '3e42eddb-54b2-eb11-8236-000d3a8747c3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP254'
end

a = Activity.find_or_create_by(stem_course_template_no: '07ddd6da-55b2-eb11-8236-000d3a8747c3') do |activity|
  activity.title = 'Physical computing kit - KS3 micro:bit'
  activity.credit = 10
  activity.slug = 'physical-computing-kit-ks3-micro-bit'
  activity.stem_course_template_no = '07ddd6da-55b2-eb11-8236-000d3a8747c3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP253'
end

a = Activity.find_or_create_by(stem_course_template_no: 'e6257895-bab4-eb11-8236-000d3a87482f') do |activity|
  activity.title = 'CSA in the summer - new to algorithms and programming track'
  activity.credit = 40
  activity.slug = 'csa-in-the-summer-new-to-algorithms-and-programming-track'
  activity.stem_course_template_no = 'e6257895-bab4-eb11-8236-000d3a87482f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP480'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'd7412f2a-beb4-eb11-8236-000d3a87482f') do |activity|
  activity.title = 'CSA in the summer - teaching advanced GCSE computer science track'
  activity.credit = 40
  activity.slug = 'csa-in-the-summer-teaching-advanced-gcse-computer-science-track'
  activity.stem_course_template_no = 'd7412f2a-beb4-eb11-8236-000d3a87482f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP481'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'ec4b4138-c0b4-eb11-8236-000d3a87482f') do |activity|
  activity.title = 'CSA in the summer - new to computing track'
  activity.credit = 40
  activity.slug = 'csa-in-the-summer-new-to-computing-track'
  activity.stem_course_template_no = 'ec4b4138-c0b4-eb11-8236-000d3a87482f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP482'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '03f27704-c2b4-eb11-8236-000d3a87482f') do |activity|
  activity.title = 'CSA in the summer - preparing to teach GCSE computer science track'
  activity.credit = 40
  activity.slug = 'csa-in-the-summer-preparing-to-teach-gcse-computer-science-track'
  activity.stem_course_template_no = '03f27704-c2b4-eb11-8236-000d3a87482f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP483'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '1c72b615-c3b4-eb11-8236-000d3a87482f') do |activity|
  activity.title = 'CSA in the summer - new to computer systems and networking track'
  activity.credit = 40
  activity.slug = 'csa-in-the-summer-new-to-computer-systems-and-networking-track'
  activity.stem_course_template_no = '1c72b615-c3b4-eb11-8236-000d3a87482f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP484'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'b740b3b5-c5b4-eb11-8236-000d3a87482f') do |activity|
  activity.title = 'CSA in the summer - teaching advanced GCSE computer science track'
  activity.credit = 40
  activity.slug = 'csa-in-the-summer-teaching-advanced-gcse-computer-science'
  activity.stem_course_template_no = 'b740b3b5-c5b4-eb11-8236-000d3a87482f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP281'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'fbd07be9-c6b4-eb11-8236-000d3a87482f') do |activity|
  activity.title = 'CSA in the summer: new to computing track'
  activity.credit = 40
  activity.slug = 'csa-in-the-summer-new-to-computing-track'
  activity.stem_course_template_no = 'fbd07be9-c6b4-eb11-8236-000d3a87482f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP280'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'e4cc4e34-329d-eb11-b1ac-000d3a86e608') do |activity|
  activity.title = 'Diagnostic assessment for GCSE computer science'
  activity.credit = 10
  activity.slug = 'diagnostic-assessment-for-gcse-computer-science'
  activity.stem_course_template_no = 'e4cc4e34-329d-eb11-b1ac-000d3a86e608'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP412'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: 'be2ded42-3fbd-eb11-bacc-0022481a6a2c') do |activity|
  activity.title = 'Adapted teaching and effective learning interventions in secondary computing'
  activity.credit = 10
  activity.slug = 'adapted-teaching-and-effective-learning-interventions-in-secondary-computing'
  activity.stem_course_template_no = 'be2ded42-3fbd-eb11-bacc-0022481a6a2c'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP448'
  activity.remote_delivered_cpd = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: 'f5f6db3c-29be-eb11-bacc-0022481a663f') do |activity|
  activity.title = 'CSA in the summer - preparing to teach GCSE computer science track'
  activity.credit = 40
  activity.slug = 'csa-in-the-summer-preparing-to-teach-gcse-computer-science-track'
  activity.stem_course_template_no = 'f5f6db3c-29be-eb11-bacc-0022481a663f'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP282'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'b7f3eb4b-42d3-eb11-bacb-0022481aa15a') do |activity|
  activity.title = 'KS3 computing (module 2): creative curriculum content, sequencing and pedagogy'
  activity.credit = 10
  activity.slug = 'ks3-computing-module-2-creative-curriculum-content-sequencing-and-pedagogy'
  activity.stem_course_template_no = 'b7f3eb4b-42d3-eb11-bacb-0022481aa15a'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP458'
  activity.remote_delivered_cpd = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

Activity.find_or_create_by(stem_course_template_no: '7d7044f3-c4ea-eb11-bacb-0022481a7a8c') do |activity|
  activity.title = 'Mentoring support for non-computing mentors'
  activity.credit = 10
  activity.slug = 'mentoring-support-for-non-computing-mentors'
  activity.stem_course_template_no = '7d7044f3-c4ea-eb11-bacb-0022481a7a8c'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP401'
  activity.remote_delivered_cpd = true
end

Activity.find_or_create_by(stem_course_template_no: 'b41096d2-c8ea-eb11-bacb-0022481a422d') do |activity|
  activity.title = 'Mentoring support for computing leads'
  activity.credit = 10
  activity.slug = 'mentoring-support-for-computing-leads'
  activity.stem_course_template_no = 'b41096d2-c8ea-eb11-bacb-0022481a422d'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP402'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: '1b149049-2f19-eb11-a813-000d3a86f6ce') do |activity|
  activity.title = 'Assessment and progression in KS3 computing'
  activity.credit = 10
  activity.slug = 'assessment-and-progression-in-ks3-computing'
  activity.stem_course_template_no = '1b149049-2f19-eb11-a813-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP212'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

Activity.find_or_create_by(stem_course_template_no: 'c9409a58-0b07-ec11-b6e6-000d3a86d86c') do |activity|
  activity.title = 'Getting started in year 3'
  activity.credit = 10
  activity.slug = 'getting-started-in-year-3'
  activity.stem_course_template_no = 'c9409a58-0b07-ec11-b6e6-000d3a86d86c'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP459'
  activity.remote_delivered_cpd = true
end

Activity.find_or_create_by(stem_course_template_no: '9dbd1486-0f07-ec11-b6e6-000d3a86d86c') do |activity|
  activity.title = 'Getting started in year 5'
  activity.credit = 10
  activity.slug = 'getting-started-in-year-5'
  activity.stem_course_template_no = '9dbd1486-0f07-ec11-b6e6-000d3a86d86c'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP460'
  activity.remote_delivered_cpd = true
end

Activity.find_or_create_by(stem_course_template_no: '0b5c8499-1307-ec11-b6e6-000d3a86d86c') do |activity|
  activity.title = 'Introduction to the Teach Computing Curriculum'
  activity.credit = 10
  activity.slug = 'introduction-to-the-teach-computing-curriculum'
  activity.stem_course_template_no = '0b5c8499-1307-ec11-b6e6-000d3a86d86c'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP461'
  activity.remote_delivered_cpd = true
end

Activity.find_or_create_by(stem_course_template_no: 'ee8a70b8-1607-ec11-b6e6-000d3a86d86c') do |activity|
  activity.title = 'Computing on a budget'
  activity.credit = 10
  activity.slug = 'computing-on-a-budget'
  activity.stem_course_template_no = 'ee8a70b8-1607-ec11-b6e6-000d3a86d86c'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP262'
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '576c1f0b-8610-ec11-b6e6-000d3a0cc552') do |activity|
  activity.title = 'KS3 computing (module 3): Creative curriculum enrichment and inclusion (remote)'
  activity.credit = 10
  activity.slug = 'ks3-computing-module-3-creative-curriculum-enrichment-and-inclusion'
  activity.stem_course_template_no = '576c1f0b-8610-ec11-b6e6-000d3a0cc552'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP449'
  activity.remote_delivered_cpd = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '88975226-811c-ec11-b6e7-0022481a8033') do |activity|
  activity.title = 'Authentic contexts for primary computing - remote'
  activity.credit = 10
  activity.slug = 'authentic-contexts-for-primary-computing-remote'
  activity.stem_course_template_no = '88975226-811c-ec11-b6e7-0022481a8033'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP405'
  activity.remote_delivered_cpd = true
end

a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: '1f24260d-0725-ec11-b6e6-000d3a0cb7ce') do |activity|
  activity.title = 'Foundation knowledge of computer science for KS3 and GCSE'
  activity.credit = 10
  activity.slug = 'foundation-knowledge-of-computer-science-for-ks3-and-gcse'
  activity.stem_course_template_no = '1f24260d-0725-ec11-b6e6-000d3a0cb7ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP426'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'bd90e3f5-1d25-ec11-b6e6-000d3a0caf8a') do |activity|
  activity.title = 'Getting started in Year 1'
  activity.credit = 10
  activity.slug = 'getting-started-in-year-1'
  activity.stem_course_template_no = 'bd90e3f5-1d25-ec11-b6e6-000d3a0caf8a'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP462'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: 'd4183159-1f25-ec11-b6e6-000d3a0ca796') do |activity|
  activity.title = 'Getting started in Year 4'
  activity.credit = 10
  activity.slug = 'getting-started-in-year-4'
  activity.stem_course_template_no = 'd4183159-1f25-ec11-b6e6-000d3a0ca796'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP465'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: '02b58914-2125-ec11-b6e6-000d3a0caf8a') do |activity|
  activity.title = 'Getting started in Year 2'
  activity.credit = 10
  activity.slug = 'getting-started-in-year-2'
  activity.stem_course_template_no = '02b58914-2125-ec11-b6e6-000d3a0caf8a'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP466'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: '95bd7135-2125-ec11-b6e6-000d3a0ca796') do |activity|
  activity.title = 'Getting started in Year 6'
  activity.credit = 10
  activity.slug = 'getting-started-in-year-6'
  activity.stem_course_template_no = '95bd7135-2125-ec11-b6e6-000d3a0ca796'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP467'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: '61b89040-5528-ec11-b6e6-000d3a0caf14') do |activity|
  activity.title = 'CS Accelerator for all'
  activity.credit = 10
  activity.slug = 'cs-accelerator-for-all'
  activity.stem_course_template_no = '61b89040-5528-ec11-b6e6-000d3a0caf14'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP333'
end

a = Activity.find_or_create_by(stem_course_template_no: 'e2683e1b-1330-ec11-b6e6-000d3a871225') do |activity|
  activity.title = 'Programming with Python – residential'
  activity.credit = 10
  activity.slug = 'programming-with-python-residential'
  activity.stem_course_template_no = 'e2683e1b-1330-ec11-b6e6-000d3a871225'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP283'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '827dccad-b130-ec11-b6e6-000d3a87150c') do |activity|
  activity.title = 'Creative digital media projects'
  activity.credit = 10
  activity.slug = 'creative-digital-media-projects'
  activity.stem_course_template_no = '827dccad-b130-ec11-b6e6-000d3a87150c'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP414'
  activity.remote_delivered_cpd = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: 'eb7c08ea-212a-4d27-8bde-a629f36192f6') do |activity|
  activity.title = 'NCCE coaching and mentoring'
  activity.credit = 10
  activity.slug = 'ncce-coaching-and-mentoring'
  activity.stem_course_template_no = 'eb7c08ea-212a-4d27-8bde-a629f36192f6'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP760'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '331f7ac5-6f56-ec11-8f8f-000d3a0cf2a0') do |activity|
  activity.title = 'Behaviour for learning in a computing environment'
  activity.credit = 10
  activity.slug = 'behaviour-for-learning-in-a-computing-environment'
  activity.stem_course_template_no = '331f7ac5-6f56-ec11-8f8f-000d3a0cf2a0'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP468'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: '01d0037f-b859-ec11-8f8f-000d3a0d0cfb') do |activity|
  activity.title = 'Teach Computing Conference'
  activity.credit = 10
  activity.slug = 'teach-computing-conference'
  activity.stem_course_template_no = '01d0037f-b859-ec11-8f8f-000d3a0d0cfb'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP310'
  activity.remote_delivered_cpd = false
end

a = Activity.find_or_create_by(stem_course_template_no: '8cdf9608-d65c-ec11-8f8f-0022481b0af9') do |activity|
  activity.title = 'Supporting student attainment in GCSE computer science - residential'
  activity.credit = 10
  activity.slug = 'supporting-student-attainment-in-gcse-computer-science-residential'
  activity.stem_course_template_no = '8cdf9608-d65c-ec11-8f8f-0022481b0af9'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP284'
  activity.remote_delivered_cpd = false
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: '6bad2c17-d85c-ec11-8f8f-0022481b0af9') do |activity|
  activity.title = 'Online safety through primary computing'
  activity.credit = 10
  activity.slug = 'online-safety-through-primary-computing'
  activity.stem_course_template_no = '6bad2c17-d85c-ec11-8f8f-0022481b0af9'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP469'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: 'ab685d74-ec5c-ec11-8f8f-0022481b0af9') do |activity|
  activity.title = 'Data-driven IT projects in secondary computing'
  activity.credit = 10
  activity.slug = 'data-driven-it-projects-in-secondary-computing'
  activity.stem_course_template_no = 'ab685d74-ec5c-ec11-8f8f-0022481b0af9'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP485'
  activity.remote_delivered_cpd = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: 'e714988b-b55d-ec11-8f8f-0022481b0af9') do |activity|
  activity.title = 'Preparing to take the CSA test - short course'
  activity.credit = 10
  activity.slug = 'preparing-to-take-the-csa-test'
  activity.stem_course_template_no = 'e714988b-b55d-ec11-8f8f-0022481b0af9'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP350'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: '890f2dfd-b85d-ec11-8f8f-0022481b0af9') do |activity|
  activity.title = 'Getting started with Python programming - short course'
  activity.credit = 10
  activity.slug = 'getting-started-with-python-programming'
  activity.stem_course_template_no = '890f2dfd-b85d-ec11-8f8f-0022481b0af9'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP351'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: '87c4cf4b-3c5f-ec11-8f8f-0022481b0426') do |activity|
  activity.title = 'Preparing for Ofsted in primary computing - short course'
  activity.credit = 10
  activity.slug = 'preparing-for-ofsted-in-primary-computing'
  activity.stem_course_template_no = '87c4cf4b-3c5f-ec11-8f8f-0022481b0426'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP486'
  activity.remote_delivered_cpd = true
end

a = Activity.find_or_create_by(stem_course_template_no: '8dc126b0-6569-ec11-8943-000d3a8700352') do |activity|
  activity.title = 'Assessment and progression in KS3 computing - Blended'
  activity.credit = 10
  activity.slug = 'assessment-and-progression-in-ks3-computing-blended'
  activity.stem_course_template_no = '8dc126b0-6569-ec11-8943-000d3a8700352'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP213'
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(stem_course_template_no: 'c53a5ed2-3c6e-ec11-8943-000d3a874094') do |activity|
  activity.title = 'Supporting GCSE computer science students at grades 1 to 3'
  activity.credit = 10
  activity.slug = 'supporting-gcse-computer-science-students-at-grades-1-to-3'
  activity.stem_course_template_no = 'c53a5ed2-3c6e-ec11-8943-000d3a874094'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP478'
  activity.remote_delivered_cpd = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

a = Activity.find_or_create_by(stem_course_template_no: 'da297734-046f-ec11-8943-000d3a8740da') do |activity|
  activity.title = 'Introduction to Isaac GCSE computer science - short course'
  activity.credit = 10
  activity.slug = 'introduction-to-isaac-gcse-computer-science'
  activity.stem_course_template_no = 'da297734-046f-ec11-8943-000d3a8740da'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
  activity.stem_activity_code = 'CP352'
end
