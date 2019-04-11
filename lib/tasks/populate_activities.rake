namespace :activities do
  task seed: :environment do
    Activity.find_or_create_by(slug: 'downloaded-diagnostic-tool') do |activity|
      activity.title = 'Downloaded diagnostic tool'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'action'
      activity.self_certifiable = true
      activity.provider = 'system'
    end

    Activity.find_or_create_by(slug: 'registered-with-the-national-centre') do |activity|
      activity.title = 'Registered with the National Centre'
      activity.credit = 5
      activity.slug = activity.title.parameterize
      activity.category = 'action'
      activity.self_certifiable = false
      activity.provider = 'system'
    end

    Activity.find_or_create_by(slug: 'teaching-physical-computing-with-raspberry-pi-and-python') do |activity|
      activity.title = 'Teaching Physical Computing with Raspberry Pi and Python'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
      activity.self_certifiable = true
      activity.provider = 'future-learn'
    end

    Activity.find_or_create_by(slug: 'how-computers-work-demystifying-computation') do |activity|
      activity.title = 'How Computers Work: Demystifying Computation'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
      activity.self_certifiable = true
      activity.provider = 'future-learn'
    end

    Activity.find_or_create_by(slug: 'programming-101-an-introduction-to-python-for-educators') do |activity|
      activity.title = 'Programming 101: An Introduction to Python for Educators'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
      activity.self_certifiable = true
      activity.provider = 'future-learn'
    end

    Activity.find_or_create_by(slug: 'programming-102-think-like-a-computer-scientist') do |activity|
      activity.title = 'Programming 102: Think like a Computer Scientist'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
      activity.self_certifiable = true
      activity.provider = 'future-learn'
    end

    Activity.find_or_create_by(slug: 'representing-data-with-images-and-sound-bringing-data-to-life') do |activity|
      activity.title = 'Representing Data with Images and Sound: Bringing Data to Life'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
      activity.self_certifiable = true
      activity.provider = 'future-learn'
    end

    Activity.find_or_create_by(slug: 'object-oriented-programming-in-python-create-your-own-adventure-game') do |activity|
      activity.title = 'Object-oriented Programming in Python: Create Your Own Adventure Game'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
      activity.self_certifiable = true
      activity.provider = 'future-learn'
    end

    Activity.find_or_create_by(slug: 'an-introduction-to-computer-networking-for-teachers') do |activity|
      activity.title = 'An Introduction to Computer Networking for Teachers'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
      activity.self_certifiable = true
      activity.provider = 'future-learn'
    end

    Activity.find_or_create_by(slug: 'understanding-maths-and-logic-in-computer-science') do |activity|
      activity.title = 'Understanding Maths and Logic in Computer Science'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
      activity.self_certifiable = true
      activity.provider = 'future-learn'
    end

    Activity.find_or_create_by(slug: 'understanding-computer-systems') do |activity|
      activity.title = 'Understanding Computer Systems'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
      activity.self_certifiable = true
      activity.provider = 'future-learn'
    end

    Activity.find_or_create_by(slug: 'teaching-programming-in-primary-schools') do |activity|
      activity.title = 'Teaching Programming in Primary Schools'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
      activity.self_certifiable = true
      activity.provider = 'future-learn'
    end

    Activity.find_or_create_by(slug: 'scratch-to-python-moving-from-block-to-text-based-programming') do |activity|
      activity.title = 'Scratch to Python: Moving from Block- to Text-based Programming'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
      activity.self_certifiable = true
      activity.provider = 'future-learn'
    end

    Activity.find_or_create_by(slug: 'algorithms-in-gcse-computer-science') do |activity|
      activity.title = 'Algorithms in GCSE computer science'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.course_id = 'a6b10502-6788-4ebc-b465-41eafb1e2a18'
      activity.category = 'cpd'
      activity.provider = 'stem-learning'
    end

    Activity.find_or_create_by(slug: 'data-and-computer-systems-in-gcse-computer-science') do |activity|
      activity.title = 'Data and computer systems in GCSE computer science'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.course_id = '7159562d-4b1a-44f3-b4d7-3e677b9898f2'
      activity.category = 'cpd'
      activity.provider = 'stem-learning'
    end

    Activity.find_or_create_by(slug: 'ncce-facilitator-development-program-stage-one') do |activity|
      activity.title = 'NCCE facilitator development program (stage one)'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.course_id = 'ec9bf026-49da-4542-abb9-2551f862d8d5'
      activity.category = 'cpd'
      activity.provider = 'stem-learning'
    end

    Activity.find_or_create_by(slug: 'ncce-train-the-trainer') do |activity|
      activity.title = 'NCCE Train the Trainer'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.course_id = '88715914-72ee-4b26-a22b-4f2d610ed267'
      activity.category = 'cpd'
      activity.provider = 'stem-learning'
    end

    Activity.find_or_create_by(slug: 'networks-and-cyber-security-in-gcse-computer-science') do |activity|
      activity.title = 'Networks and cyber-security in GCSE computer science'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.course_id = '0650b45c-e4b3-4c8b-bd90-7a1428fe2986'
      activity.category = 'cpd'
      activity.provider = 'stem-learning'
    end

    Activity.find_or_create_by(slug: 'outstanding-teaching-of-key-stage-1-computing') do |activity|
      activity.title = 'Outstanding teaching of key stage 1 computing'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.course_id = '488bed9b-515b-4295-a488-62b5bb6bf852'
      activity.category = 'cpd'
      activity.provider = 'stem-learning'
    end

    Activity.find_or_create_by(slug: 'outstanding-teaching-of-key-stage-2-computing') do |activity|
      activity.title = 'Outstanding teaching of key stage 2 computing'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.course_id = '16aeecbd-d202-4f42-bad3-f86c8f671547'
      activity.category = 'cpd'
      activity.provider = 'stem-learning'
    end

    Activity.find_or_create_by(slug: 'primary-programming-and-algorithms') do |activity|
      activity.title = 'Primary programming and algorithms'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.course_id = '68f5b6c5-556d-4b66-8159-7cd6019da6f3'
      activity.category = 'cpd'
      activity.provider = 'stem-learning'
    end

    Activity.find_or_create_by(slug: 'python-programming-essentials-for-gcse-computer-science') do |activity|
      activity.title = 'Python programming essentials for GCSE computer science'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.course_id = '92f4f86e-0237-4ecc-a905-2f6c62d6b5ae'
      activity.category = 'cpd'
      activity.provider = 'stem-learning'
    end
  end
end
