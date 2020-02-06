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
