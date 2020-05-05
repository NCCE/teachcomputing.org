Activity.find_or_create_by(slug: 'algorithms-in-gcse-computer-science') do |activity|
  activity.title = 'Algorithms in GCSE computer science'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.stem_course_template_no = 'a6b10502-6788-4ebc-b465-41eafb1e2a18'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'data-and-computer-systems-in-gcse-computer-science') do |activity|
  activity.title = 'Data and computer systems in GCSE computer science'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.stem_course_template_no = '7159562d-4b1a-44f3-b4d7-3e677b9898f2'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'ncce-facilitator-development-program-stage-one') do |activity|
  activity.title = 'NCCE facilitator development program (stage one)'
  activity.credit = 0
  activity.slug = activity.title.parameterize
  activity.stem_course_template_no = 'ec9bf026-49da-4542-abb9-2551f862d8d5'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'ncce-train-the-trainer') do |activity|
  activity.title = 'NCCE Train the Trainer'
  activity.credit = 0
  activity.slug = activity.title.parameterize
  activity.stem_course_template_no = '88715914-72ee-4b26-a22b-4f2d610ed267'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'networks-and-cyber-security-in-gcse-computer-science') do |activity|
  activity.title = 'Networks and Cyber Security in GCSE computer science'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.stem_course_template_no = '0650b45c-e4b3-4c8b-bd90-7a1428fe2986'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'teaching-and-leading-key-stage-1-computing') do |activity|
  activity.title = 'Teaching and leading key stage 1 computing'
  activity.credit = 40
  activity.slug = activity.title.parameterize
  activity.stem_course_template_no = '488bed9b-515b-4295-a488-62b5bb6bf852'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'teaching-and-leading-key-stage-2-computing') do |activity|
  activity.title = 'Teaching and leading key stage 2 computing'
  activity.credit = 40
  activity.slug = activity.title.parameterize
  activity.stem_course_template_no = '16aeecbd-d202-4f42-bad3-f86c8f671547'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'primary-programming-and-algorithms') do |activity|
  activity.title = 'Primary programming and algorithms'
  activity.credit = 40
  activity.slug = activity.title.parameterize
  activity.stem_course_template_no = '68f5b6c5-556d-4b66-8159-7cd6019da6f3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'python-programming-essentials-for-gcse-computer-science') do |activity|
  activity.title = 'Python programming essentials for GCSE computer science'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.stem_course_template_no = '92f4f86e-0237-4ecc-a905-2f6c62d6b5ae'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'creative-computing-for-key-stage-3') do |activity|
  activity.title = 'Creative Computing for Key Stage 3'
  activity.credit = 0
  activity.slug = activity.title.parameterize
  activity.stem_course_template_no = '26c20962-6279-4927-b797-42363848130c'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'gcse-computer-science-developing-outstanding-teaching') do |activity|
  activity.title = 'GCSE Computer Science - developing outstanding teaching'
  activity.credit = 0
  activity.slug = activity.title.parameterize
  activity.stem_course_template_no = '1dcba944-6ae9-4b68-af69-56df49495bd7'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'ks4-computing-for-all') do |activity|
  activity.title = 'KS4 computing for all'
  activity.credit = 0
  activity.slug = activity.title.parameterize
  activity.stem_course_template_no = '258c93cc-69e2-46f6-bf39-fbce27cb8fc2'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'pre-january-2019-csa-face-to-face-cpd') do |activity|
  activity.title = 'Pre January 2019 CSA Face to Face CPD'
  activity.credit = 40
  activity.slug = 'pre-january-2019-csa-face-to-face-cpd'
  activity.stem_course_template_no = 'f7fefbae-53aa-4c28-bbd2-b3d3b1bf7bbd'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'key-stage-3-computing-for-non-specialists') do |activity|
  activity.title = 'Key stage 3 computing for non-specialists'
  activity.credit = 0
  activity.slug = 'key-stage-3-computing-for-non-specialists'
  activity.stem_course_template_no = '46c07f3e-b9b2-4f0c-ba56-52319aadb955'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'introduction-to-gcse-computer-science') do |activity|
  activity.title = 'Introduction to GCSE computer science'
  activity.credit = 20
  activity.slug = 'introduction-to-gcse-computer-science'
  activity.stem_course_template_no = '87bf64c2-6517-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'search-and-sort-algorithms') do |activity|
  activity.title = 'Search and sort algorithms'
  activity.credit = 10
  activity.slug = 'search-and-sort-algorithms'
  activity.stem_course_template_no = '0d64b3cd-b866-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'representing-algorithms-using-flowcharts-and-pseudocode') do |activity|
  activity.title = 'Representing algorithms using flowcharts and pseudocode'
  activity.credit = 10
  activity.slug = 'representing-algorithms-using-flowcharts-and-pseudocode'
  activity.stem_course_template_no = '1199992c-3665-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'computer-systems-input-output-and-storage') do |activity|
  activity.title = 'Computer systems: input, output and storage'
  activity.credit = 10
  activity.slug = 'computer-systems-input-output-and-storage'
  activity.stem_course_template_no = '80d93c0f-be66-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'computer-processors') do |activity|
  activity.title = 'Computer processors'
  activity.credit = 10
  activity.slug = 'computer-processors'
  activity.stem_course_template_no = '94b15af9-c066-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'fundamentals-of-computer-networks') do |activity|
  activity.title = 'Fundamentals of computer networks'
  activity.credit = 10
  activity.slug = 'fundamentals-of-computer-networks'
  activity.stem_course_template_no = 'ff9ee9a5-6267-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'the-internet-and-cyber-security') do |activity|
  activity.title = 'The internet and cyber-security'
  activity.credit = 10
  activity.slug = 'the-internet-and-cyber-security'
  activity.stem_course_template_no = '46d64f78-6367-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'python-programming-constructs-sequencing-selection-iteration') do |activity|
  activity.title = 'Python programming constructs: sequencing, selection, iteration'
  activity.credit = 10
  activity.slug = 'python-programming-constructs-sequencing-selection-iteration'
  activity.stem_course_template_no = '43476cb7-6567-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'python-programming-working-with-data') do |activity|
  activity.title = 'Python programming: working with data'
  activity.credit = 10
  activity.slug = 'python-programming-working-with-data'
  activity.stem_course_template_no = '84568ccf-6767-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'an-introduction-to-algorithms-programming-and-data-in-gcse-computer-science') do |activity|
  activity.title = 'An introduction to algorithms, programming and data in GCSE Computer Science'
  activity.credit = 10
  activity.slug = 'an-introduction-to-algorithms-programming-and-data-in-gcse-computer-science'
  activity.stem_course_template_no = 'de08c1a9-3868-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'an-introduction-to-computer-systems-networking-and-security-in-gcse-computer-science') do |activity|
  activity.title = 'An introduction to computer systems, networking and security in GCSE computer science'
  activity.credit = 10
  activity.slug = 'an-introduction-to-computer-systems-networking-and-security-in-gcse-computer-science'
  activity.stem_course_template_no = '17d78590-4268-ea11-a811-000d3a86d7a3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'representing-algorithms-using-flowcharts-and-pseudocode-remote') do |activity|
  activity.title = 'Representing algorithms using flowcharts and pseudocode'
  activity.credit = 10
  activity.slug = 'representing-algorithms-using-flowcharts-and-pseudocode-remote'
  activity.stem_course_template_no = '07e76ffd-e17f-ea11-a811-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'fundamentals-of-computer-networks-remote') do |activity|
  activity.title = 'Fundamentals of Computer Networks'
  activity.credit = 10
  activity.slug = 'fundamentals-of-computer-networks-remote'
  activity.stem_course_template_no = 'dd8a8433-e57f-ea11-a811-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'python-programming-constructs-sequencing-selection-iteration-remote') do |activity|
  activity.title = 'Python programming constructs: sequencing, selection & iteration'
  activity.credit = 10
  activity.slug = 'python-programming-constructs-sequencing-selection-iteration-remote'
  activity.stem_course_template_no = '935a0639-e87f-ea11-a811-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'teaching-and-leading-key-stage-1-computing-module-1') do |activity|
  activity.title = 'Teaching and leading key stage 1 computing - Module 1'
  activity.credit = 10
  activity.slug = 'teaching-and-leading-key-stage-1-computing-module-1'
  activity.stem_course_template_no = 'e432e725-ba7f-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'teaching-and-leading-key-stage-1-computing-module-2') do |activity|
  activity.title = 'Teaching and leading key stage 1 computing - Module 2'
  activity.credit = 10
  activity.slug = 'teaching-and-leading-key-stage-1-computing-module-2'
  activity.stem_course_template_no = '5b694e80-ce7f-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'teaching-and-leading-key-stage-2-computing-module-1') do |activity|
  activity.title = 'Teaching and leading key stage 2 computing - Module 1'
  activity.credit = 10
  activity.slug = 'teaching-and-leading-key-stage-2-computing-module-1'
  activity.stem_course_template_no = 'a533bf46-d17f-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'teaching-and-leading-key-stage-2-computing-module-2') do |activity|
  activity.title = 'Teaching and leading key stage 2 computing - Module 2'
  activity.credit = 10
  activity.slug = 'teaching-and-leading-key-stage-2-computing-module-2'
  activity.stem_course_template_no = '5fdb7188-dd7f-ea11-a811-000d3a86f6ce'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'introduction-to-algorithms-programming-and-data-in-gcse-computer-science-remote') do |activity|
  activity.title = 'Introduction to algorithms, programming and data in GCSE computer science'
  activity.credit = 10
  activity.slug = 'introduction-to-algorithms-programming-and-data-in-gcse-computer-science-remote'
  activity.stem_course_template_no = '526b3a42-b688-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'computer-processors-remote') do |activity|
  activity.title = 'Computer processors'
  activity.credit = 10
  activity.slug = 'computer-processors-remote'
  activity.stem_course_template_no = '65fe83ad-b188-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'the-internet-and-cyber-security-remote') do |activity|
  activity.title = 'The Internet and Cyber Security'
  activity.credit = 10
  activity.slug = 'the-internet-and-cyber-security-remote'
  activity.stem_course_template_no = '770d8136-3d86-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'python-programming-working-with-data-remote') do |activity|
  activity.title = 'Python programming: working with data'
  activity.credit = 10
  activity.slug = 'python-programming-working-with-data-remote'
  activity.stem_course_template_no = '67a21143-4886-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'an-introduction-to-computer-systems-networking-and-security-in-gcse-computer-science-remote') do |activity|
  activity.title = 'An introduction to computer systems, networking and security in GCSE computer science'
  activity.credit = 10
  activity.slug = 'an-introduction-to-computer-systems-networking-and-security-in-gcse-computer-science-remote'
  activity.stem_course_template_no = 'bd6497ad-4386-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'key-stage-3-computing-for-the-non-specialist-teacher-remote') do |activity|
  activity.title = 'Key Stage 3 computing for the non-specialist teacher'
  activity.credit = 10
  activity.slug = 'key-stage-3-computing-for-the-non-specialist-teacher-remote'
  activity.stem_course_template_no = 'dbb7808c-b888-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'introduction-to-primary-computing-remote') do |activity|
  activity.title = 'Introduction to primary computing'
  activity.credit = 10
  activity.slug = 'introduction-to-primary-computing-remote'
  activity.stem_course_template_no = 'bb7a0f31-5086-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'primary-programming-and-algorithms-remote') do |activity|
  activity.title = 'Primary programming and algorithms'
  activity.credit = 10
  activity.slug = 'primary-programming-and-algorithms-remote'
  activity.stem_course_template_no = '6bc40e34-4c86-ea11-a811-000d3a86d545'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end
