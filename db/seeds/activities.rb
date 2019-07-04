Activity.find_or_create_by(slug: 'diagnostic-tool') do |activity|
  activity.title = 'Used the diagnostic tool'
  activity.credit = 10
  activity.slug = 'diagnostic-tool'
  activity.category = 'action'
  activity.self_certifiable = true
  activity.provider = 'system'
end

Activity.find_or_create_by(slug: 'registered-with-the-national-centre') do |activity|
  activity.title = 'Created your account with the National Centre for Computing Education'
  activity.credit = 5
  activity.slug = 'registered-with-the-national-centre'
  activity.category = 'action'
  activity.self_certifiable = false
  activity.provider = 'system'
end

Activity.find_or_create_by(slug: 'teaching-physical-computing-with-raspberry-pi-and-python') do |activity|
  activity.title = 'Teaching Physical Computing with Raspberry Pi and Python'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'ecf78d20-2966-4798-af5f-0f869c1818e2'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'how-computers-work-demystifying-computation') do |activity|
  activity.title = 'How Computers Work: Demystifying Computation'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'c88099c0-8b44-42a5-aad3-0dd011fe3490'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'programming-101-an-introduction-to-python-for-educators') do |activity|
  activity.title = 'Programming 101: An Introduction to Python for Educators'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'c9fb59cc-6393-4a29-8136-7020128ca879'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'programming-102-think-like-a-computer-scientist') do |activity|
  activity.title = 'Programming 102: Think like a Computer Scientist'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'd9fe6126-298f-48ed-8be3-b82e1c473566'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'representing-data-with-images-and-sound-bringing-data-to-life') do |activity|
  activity.title = 'Representing Data with Images and Sound: Bringing Data to Life'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'e290318f-ba23-4c95-8f18-584946233af9'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'object-oriented-programming-in-python-create-your-own-adventure-game') do |activity|
  activity.title = 'Object-oriented Programming in Python: Create Your Own Adventure Game'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = '2e1e3f69-b200-4fc7-a6bd-dff682bdd228'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'an-introduction-to-computer-networking-for-teachers') do |activity|
  activity.title = 'An Introduction to Computer Networking for Teachers'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = '6c5bddfb-7dd4-467b-9554-34f3aedc233f'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'understanding-maths-and-logic-in-computer-science') do |activity|
  activity.title = 'Understanding Maths and Logic in Computer Science'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'ffc6793d-5643-40c8-893a-0164844ca62f'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'understanding-computer-systems') do |activity|
  activity.title = 'Understanding Computer Systems'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = '04953102-a4cf-485d-a34e-0c64621033be'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'teaching-programming-in-primary-schools') do |activity|
  activity.title = 'Teaching Programming in Primary Schools'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = '4ec560a3-6435-46bc-90b7-75cfdcf7e72d'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'scratch-to-python-moving-from-block-to-text-based-programming') do |activity|
  activity.title = 'Scratch to Python: Moving from Block- to Text-based Programming'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = '3ce9a624-6cc7-4d23-8f5f-95162e360178'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'impact-of-technology-how-to-lead-classroom-discussions') do |activity|
  activity.title = 'Impact of Technology: How To Lead Classroom Discussions'
  activity.credit = 0
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'e4115d3c-53d0-4538-94c2-e2a9ba366178'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'introduction-to-cybersecurity-for-teachers') do |activity|
  activity.title = 'Introduction to Cybersecurity for Teachers'
  activity.credit = 10
  activity.slug = 'introduction-to-cybersecurity-for-teachers'
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = '030261f8-1e96-4a70-a329-e3eb8b868915'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'algorithms-in-gcse-computer-science') do |activity|
  activity.title = 'Algorithms in GCSE computer science'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.stem_course_id = 'a6b10502-6788-4ebc-b465-41eafb1e2a18'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'data-and-computer-systems-in-gcse-computer-science') do |activity|
  activity.title = 'Data and computer systems in GCSE computer science'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.stem_course_id = '7159562d-4b1a-44f3-b4d7-3e677b9898f2'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'ncce-facilitator-development-program-stage-one') do |activity|
  activity.title = 'NCCE facilitator development program (stage one)'
  activity.credit = 0
  activity.slug = activity.title.parameterize
  activity.stem_course_id = 'ec9bf026-49da-4542-abb9-2551f862d8d5'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'ncce-train-the-trainer') do |activity|
  activity.title = 'NCCE Train the Trainer'
  activity.credit = 0
  activity.slug = activity.title.parameterize
  activity.stem_course_id = '88715914-72ee-4b26-a22b-4f2d610ed267'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'networks-and-cyber-security-in-gcse-computer-science') do |activity|
  activity.title = 'Networks and Cyber Security in GCSE computer science'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.stem_course_id = '0650b45c-e4b3-4c8b-bd90-7a1428fe2986'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'outstanding-teaching-of-key-stage-1-computing') do |activity|
  activity.title = 'Outstanding teaching of key stage 1 computing'
  activity.credit = 40
  activity.slug = activity.title.parameterize
  activity.stem_course_id = '488bed9b-515b-4295-a488-62b5bb6bf852'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'outstanding-teaching-of-key-stage-2-computing') do |activity|
  activity.title = 'Outstanding teaching of key stage 2 computing'
  activity.credit = 40
  activity.slug = activity.title.parameterize
  activity.stem_course_id = '16aeecbd-d202-4f42-bad3-f86c8f671547'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'primary-programming-and-algorithms') do |activity|
  activity.title = 'Primary programming and algorithms'
  activity.credit = 40
  activity.slug = activity.title.parameterize
  activity.stem_course_id = '68f5b6c5-556d-4b66-8159-7cd6019da6f3'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'python-programming-essentials-for-gcse-computer-science') do |activity|
  activity.title = 'Python programming essentials for GCSE computer science'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.stem_course_id = '92f4f86e-0237-4ecc-a905-2f6c62d6b5ae'
  activity.category = 'face-to-face'
  activity.provider = 'stem-learning'
end

Activity.find_or_create_by(slug: 'cs-accelerator-assessment') do |activity|
  activity.title = 'CS Accelerator Assessment'
  activity.credit = 30
  activity.slug = activity.title.parameterize
  activity.category = 'assessment'
  activity.provider = 'classmarker'
end

Activity.all.each do |a|
  puts "Created activity #{a.title} (#{a})"
end
