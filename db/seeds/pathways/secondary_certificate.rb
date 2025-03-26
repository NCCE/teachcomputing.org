puts "Creating Pathways for Secondary Certificate"

programme = Programme.secondary_certificate

programme.pathways.find_or_initialize_by(slug: "curriculum-leadership").tap do |pathway|
  pathway.title = "Curriculum leadership"
  pathway.slug = "curriculum-leadership"
  pathway.description = "Are you currently a Computing Lead or are looking to progress into the role? This pathway will support you to build the confidence to lead computing effectively in your school."
  pathway.range = 0..0
  pathway.pdf_link = "https://static.teachcomputing.org/Secondary_Pathway_01_Curriculum_leadership.pdf"
  pathway.programme_id = programme.id
  pathway.order = 1

  pathway.improvement_bullets = [
    "Leadership and Vision",
    "Curriculum and Qualifications",
    "Staff Development",
    "Impact on Outcomes"
  ]
  pathway.improvement_cta = 'As defined in the <a href="https://computingqualityframework.org/">Computing Quality Framework</a>'

  pathway.enrol_copy = [
    "Enrol with the click of the button",
    "Complete the required professional development",
    "Complete engagement activities to support your learning",
    'Successfully complete the <a href="https://teachcomputing.org/subject-knowledge">Subject knowledge certificate</a>',
    "Receive your certificate"
  ]

  pathway.save!

  cpds = %w[CO411A CO478 CO444 CO439 CO413 CO411A CO249 CO247 CO248 CP448 CP440 CO700 CP446 CO222 CP468 CP212 CO230]
  cpds.each do |cpd|
    maybe_attach_activity_to_pathway(pathway, stem_activity_code: cpd)
  end

  remove_cpds = %w[CP247 CP248 CP249 CP211 CP411 CP413 CP439 CP444 CP478]

  remove_cpds.each do |cpd|
    maybe_detach_activity_from_pathway(pathway, stem_activity_code: cpd)
  end

  activities = [
    # Make a positive impact on young people in computing
    "raise-aspirations-with-a-stem-ambassador-visit",
    "participate-fully-in-an-ncce-curriculum-enrichment-oppertunity",
    "implement-your-professional-development-in-the-classroom-and-evaluate-via-the-impact-toolkit",
    "download-and-use-the-ncce-teaching-and-assessment-resources-in-your-classroom",
    # Support your professional community
    "gain-accreditation-as-a-professional-development-leader",
    "support-other-teachers-and-earn-a-stem-community-participation-badge-secondary",
    "undertake-the-initial-assessment-of-your-school-using-computing-quality-framework",
    "work-with-your-local-computing-hub-to-develop-a-school-level-action-plan-for-professional-development",
    "lead-your-school-into-a-computing-cluster-and-develop-an-action-plan-with-a-cluster-advisor",
    "join-and-present-at-your-local-computing-at-school-community"
  ]

  activities.each do |activity|
    maybe_attach_activity_to_pathway(pathway, slug: activity)
  end

  remove_activities = []

  remove_activities.each do |activity|
    maybe_detach_activity_from_pathway(pathway, slug: activity)
  end
end.save!

programme.pathways.find_or_initialize_by(slug: "supporting-other-teachers").tap do |pathway|
  pathway.title = "Supporting other teachers"
  pathway.slug = "supporting-other-teachers"
  pathway.description = "Are you looking to support your colleagues through mentoring, collaborative working and sharing expertise? This pathway will help you aid your colleagues to deliver excellent computer science education to students."
  pathway.range = 0..0
  pathway.pdf_link = "https://static.teachcomputing.org/Secondary_Pathway_02_Supporting_other_teachers.pdf"
  pathway.programme_id = programme.id
  pathway.order = 2

  pathway.improvement_bullets = [
    "Staff Development",
    "Teaching, Learing and Assessment"
  ]
  pathway.improvement_cta = 'As defined in the <a href="https://computingqualityframework.org/">Computing Quality Framework</a>'

  pathway.enrol_copy = [
    "Enrol with the click of the button",
    "Complete the required professional development",
    "Complete engagement activities to support your learning",
    'Successfully complete the <a href="https://teachcomputing.org/subject-knowledge">Subject knowledge certificate</a>',
    "Receive your certificate"
  ]

  pathway.save!

  cpds = %w[CP207 CP437 CP447 CP448 CO222 CO215 CP468 CP440 CP446]
  cpds.each do |cpd|
    maybe_attach_activity_to_pathway(pathway, stem_activity_code: cpd)
  end

  activities = [
    "participate-fully-in-an-ncce-curriculum-enrichment-oppertunity",
    "download-and-use-the-ncce-teaching-and-assessment-resources-in-your-classroom",
    "join-the-ib-encouraging-girls-into-cs-programme-and-become-an-ibc",
    # Support your professional community
    "gain-accreditation-as-a-professional-development-leader",
    "undertake-the-initial-assessment-of-your-school-using-computing-quality-framework",
    "lead-your-school-into-a-computing-cluster-and-develop-an-action-plan-with-a-cluster-advisor",
    "join-and-present-at-your-local-computing-at-school-community",
    "support-other-teachers-and-earn-a-stem-community-participation-badge-secondary"
  ]

  activities.each do |activity|
    maybe_attach_activity_to_pathway(pathway, slug: activity)
  end

  remove_activities = [
    "raise-aspirations-with-a-stem-ambassador-visit"
  ]

  remove_activities.each do |activity|
    maybe_detach_activity_from_pathway(pathway, slug: activity)
  end
end.save!

programme.pathways.find_or_initialize_by(slug: "championing-diversity-and-inclusion").tap do |pathway|
  pathway.title = "Championing diversity and inclusion"
  pathway.slug = "championing-diversity-and-inclusion"
  pathway.description = "Are you looking to champion diversity and inclusion in your classrooms as well as computing as a subject? This pathway will give you knowledge of teaching interventions, encouraging girls into computer science and how to support SEND students in their learning of computing."
  pathway.range = 0..0
  pathway.pdf_link = "https://static.teachcomputing.org/Secondary_Pathway_03_Championing_deversity_and_inclusion.pdf"
  pathway.programme_id = programme.id
  pathway.order = 3

  pathway.improvement_bullets = [
    "Equity, Diversity, Inclusion and SEND"
  ]
  pathway.improvement_cta = 'As defined in the <a href="https://computingqualityframework.org/">Computing Quality Framework</a>'

  pathway.enrol_copy = [
    "Enrol with the click of the button",
    "Complete the required professional development",
    "Complete engagement activities to support your learning",
    'Successfully complete the <a href="https://teachcomputing.org/subject-knowledge">Subject knowledge certificate</a>',
    "Receive your certificate"
  ]

  pathway.save!

  cpds = %w[CO249 CP440 CO700 CP448 CP437 CP291 CP414]
  cpds.each do |cpd|
    maybe_attach_activity_to_pathway(pathway, stem_activity_code: cpd)
  end

  remove_cpds = %w[CP249]

  remove_cpds.each do |cpd|
    maybe_detach_activity_from_pathway(pathway, stem_activity_code: cpd)
  end

  activities = [
    "raise-aspirations-with-a-stem-ambassador-visit",
    "participate-fully-in-an-ncce-curriculum-enrichment-oppertunity",
    "implement-your-professional-development-in-the-classroom-and-evaluate-via-the-impact-toolkit",
    "download-and-use-isaac-computer-science-classroom-resources-and-displays",
    "complete-the-i-belong-programme-as-a-school",
    # Support your professional community
    "gain-accreditation-as-a-professional-development-leader",
    "support-other-teachers-and-earn-a-stem-community-participation-badge-secondary",
    "work-with-local-business-and-industry-to-inspire-inclusive-computing",
    "lead-your-school-into-a-computing-cluster-and-develop-an-action-plan-with-a-cluster-advisor",
    "join-and-present-at-your-local-computing-at-school-community",
    "become-an-i-belong-champion"
  ]

  activities.each do |activity|
    maybe_attach_activity_to_pathway(pathway, slug: activity)
  end

  remove_activities = []

  remove_activities.each do |activity|
    maybe_detach_activity_from_pathway(pathway, slug: activity)
  end
end.save!

programme.pathways.find_or_initialize_by(slug: "raising-student-attainment").tap do |pathway|
  pathway.title = "Raising student attainment"
  pathway.slug = "raising-student-attainment"
  pathway.description = "Are you looking to raise attainment amongst different groups of students? This pathway will help you support young people to overcome challenges, champion diversity in your school and increase student engagement in the subject of computing."
  pathway.range = 0..0
  pathway.pdf_link = "https://static.teachcomputing.org/Secondary_Pathway_04_Raising_student_attainment.pdf"
  pathway.programme_id = programme.id
  pathway.order = 4

  pathway.improvement_bullets = [
    "Teaching, Learning and Assessment",
    "Impact on Outcomes",
    "Careers Education"
  ]
  pathway.improvement_cta = 'As defined in the <a href="https://computingqualityframework.org/">Computing Quality Framework</a>'

  pathway.enrol_copy = [
    "Enrol with the click of the button",
    "Complete the required professional development",
    "Complete engagement activities to support your learning",
    'Successfully complete the <a href="https://teachcomputing.org/subject-knowledge">Subject knowledge certificate</a>',
    "Receive your certificate"
  ]

  pathway.save!

  cpds = %w[CO478 CO439 CO413 CP447 CP241 CP207 CP212 CP242 CP446 CP468 CP412 CP212]
  cpds.each do |cpd|
    maybe_attach_activity_to_pathway(pathway, stem_activity_code: cpd)
  end

  remove_cpds = %w[CP413 CP439 CP478]

  remove_cpds.each do |cpd|
    maybe_detach_activity_from_pathway(pathway, stem_activity_code: cpd)
  end

  activities = [
    "raise-aspirations-with-a-stem-ambassador-visit",
    "participate-fully-in-an-ncce-curriculum-enrichment-oppertunity",
    "implement-your-professional-development-in-the-classroom-and-evaluate-via-the-impact-toolkit",
    "download-and-use-the-ncce-teaching-and-assessment-resources-in-your-classroom",
    # Support your local professional community
    "gain-accreditation-as-a-professional-development-leader",
    "support-other-teachers-and-earn-a-stem-community-participation-badge-secondary",
    "undertake-the-initial-assessment-of-your-school-using-computing-quality-framework",
    "work-with-your-local-computing-hub-to-develop-a-school-level-action-plan-for-professional-development",
    "lead-your-school-into-a-computing-cluster-and-develop-an-action-plan-with-a-cluster-advisor",
    "join-and-present-at-your-local-computing-at-school-community"
  ]

  activities.each do |activity|
    maybe_attach_activity_to_pathway(pathway, slug: activity)
  end

  remove_activities = []

  remove_activities.each do |activity|
    maybe_detach_activity_from_pathway(pathway, slug: activity)
  end
end.save!

programme.pathways.find_or_initialize_by(slug: "developing-teachers").tap do |pathway|
  pathway.title = "Developing teachers"
  pathway.slug = "developing-teachers"
  pathway.description = "Are you looking to develop your teaching after the Early Career Framework? This pathways will support your development goals and will help increase your knowledge of the subject and pedagogy."
  pathway.range = 0..0
  pathway.pdf_link = "https://static.teachcomputing.org/Secondary_Pathway_05_Developing_teachers.pdf"
  pathway.programme_id = programme.id
  pathway.order = 5

  pathway.improvement_bullets = [
    "Teaching, Learning and Assessment"
  ]
  pathway.improvement_cta = 'As defined in the <a href="https://computingqualityframework.org/">Computing Quality Framework</a>'

  pathway.enrol_copy = [
    "Enrol with the click of the button",
    "Complete the required professional development",
    "Complete engagement activities to support your learning",
    'Successfully complete the <a href="https://teachcomputing.org/subject-knowledge">Subject knowledge certificate</a>',
    "Receive your certificate"
  ]

  pathway.save!

  cpds = %w[CO478 CO439 CP448 CO700 CO222 CP446 CP468]
  cpds.each do |cpd|
    maybe_attach_activity_to_pathway(pathway, stem_activity_code: cpd)
  end

  remove_cpds = %w[CP439 CP478]

  remove_cpds.each do |cpd|
    maybe_detach_activity_from_pathway(pathway, stem_activity_code: cpd)
  end

  activities = [
    "raise-aspirations-with-a-stem-ambassador-visit",
    "participate-fully-in-an-ncce-curriculum-enrichment-oppertunity",
    "implement-your-professional-development-in-the-classroom-and-evaluate-via-the-impact-toolkit",
    # Support your lcal professional community
    "gain-accreditation-as-a-professional-development-leader",
    "support-other-teachers-and-earn-a-stem-community-participation-badge-secondary",
    "work-with-local-business-and-industry-to-inspire-inclusive-computing"
  ]

  activities.each do |activity|
    maybe_attach_activity_to_pathway(pathway, slug: activity)
  end

  remove_activities = [
    "gain-accreditation-as-an-i-belong-champion"
  ]

  remove_activities.each do |activity|
    maybe_detach_activity_from_pathway(pathway, slug: activity)
  end
end.save!
