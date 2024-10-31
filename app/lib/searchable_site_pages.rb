class SearchableSitePages
  include Rails.application.routes.url_helpers

  def self.all
    new.all
  end

  def initialize
    @pages = []

    build_pages
  end

  def all
    @pages
  end

  private

  def path(path, title, excerpt = "")
    @pages << {path:, title:, excerpt:}
  end

  def build_pages
    path courses_path, "Computing courses for teachers", "Discover our range of professional development courses, designed to help you teach computing. Courses cover key stages 1 to 4 and cater for all levels of knowledge."

    build_pathway_pages
    build_curriculum_pages

    path about_path, "About us", "The National Centre for Computing Education (NCCE) is funded by the Department for Education and supporting partners and marks a significant investment in improving the provision of computing education in England."
    path accessibility_statement_path, "Accessibility statement", "We are committed to making our website more accessible and inclusive for everyone. This is an important part of our aim to ensure that everyone who visits the National Centre for Computing Education website feels welcome."
    path careers_week_path, "Careers in computing", "With the demand for digital skills growing, there has never been a more important time to prepare young people for their future."
    path competition_terms_and_conditions_path, "Prize draws and competitions", "From time to time, we may run prize draws and/or competitions on our site. For each prize draw and/or competition, the following terms will also apply."
    path about_isaac_computer_science_path, "Isaac Computer Science", "Access a huge range of time-saving learning materials that cover the full A level and GCSE Computer Science curricula for the AQA, OCR, Edexcel, and Eduqas exam specifications — all for free!"
    path gender_balance_path, "Gender Balance in Computing", "Gender Balance in Computing is a collaboration between the Raspberry Pi Foundation; STEM Learning; BCS, The Chartered Institute for IT; the Behavioural Insights Team; Apps for Good; and WISE."
    path get_involved_path, "Get involved", "Our vision is for every child in every school in England to have a world-leading computing education. Join our efforts to ensure young people are equipped with the necessary skills for the future."
    path secondary_question_banks_path, "Secondary question banks", "The collection includes a series of 10 topics, covering areas across the computing curriculum. Each topic area includes two sets of questions, setup as both Google and Microsoft Forms, allowing you to duplicate into your own account/s to use with your students."
    path pedagogy_path, "Promoting effective computing pedagogy", "Effective pedagogy is at the heart of good teaching and learning; successful computing teachers combine their knowledge of the subject with evidence-based teaching practices. As computing is a relatively new discipline, evidence of effective teaching approaches continues to emerge and evolve."
    path impact_path, "Impact, evaluation and research", "Our vision is for every child in every school in England to have a world-leading computing education. We continually evaluate the impact that our programmes, services and resources are having on improving the quality of teaching computing in schools, and the learning experience for young people."
    path secondary_senior_leaders_path, "Support for Secondary Senior Leaders", "Funded by the Department for Education, the National Centre for Computing Education offers a comprehensive range of support for schools and colleges, including free resources and high-impact training, to drive school improvement and pupil outcomes."
    path secondary_teachers_path, "The essential toolkit for secondary computing teachers", "Begin your computing journey, develop your understanding of a specific topic, or improve your pedagogical practice. We offer subsidies to state-funded schools to support supply cover."
    path terms_conditions_path, "National Centre for Computing Education Terms and Conditions", "This website is part of the National Centre for Computing Education. The National Centre for Computing Education is funded by the Department for Education and operated by STEM Learning."
    path primary_enrichment_path, "Primary computing enrichment activities", "Explore a variety of activities, challenges and opportunities provided by the National Centre for Computing Education (NCCE) and our partners. All are designed to enrich learning in computing and provide opportunities to broaden young people’s educational experience, inspire their curiosity and expand on what computing means to them in a fun hands-on way."
    path secondary_enrichment_path, "Secondary computing enrichment activities", "The National Centre for Computing Education (NCCE) enrichment activities will help inspire curiosity in your students and broaden their educational experience with fun hands-on learning."

    path primary_path, "Teach primary computing", "This professional development programme has been designed to guide primary teachers through our comprehensive offer of courses, enrichment and resources and leads to a nationally recognised certificate. We expect it to take around 20 hours to complete."
    path secondary_certification_path, "Secondary Teacher Certification", "Develop your subject knowledge and classroom practice with a National Centre for Computing Education certificate; improve your confidence and take your career to the next level."
    path secondary_path, "Teach secondary computing", "This professional development programme is designed to enhance how you teach secondary computing, and to give you confidence to apply those skills in the classroom. Throughout your learning journey, you'll get the opportunity to develop yourself, your professional community, and your students, by engaging in a range of activities."
    path cs_accelerator_path, "Subject knowledge certificate", "Computer Science Accelerator is a professional development programme for teachers, funded by the Department for Education, leading to a national certificate in computer science subject knowledge."
    path about_a_level_path, "A level Computer Science subject knowledge", "This certificate is for anyone planning to teach A level Computer Science or currently doing so. It is particularly valuable to teachers without qualifications in the subject who wish to demonstrate the capability to teach at this level."
    path about_i_belong_path, "I Belong: encouraging girls into computer science", "Computer science is the fastest-growing STEM subject, and yet, despite its popularity, girls are consistently outnumbered by boys. In 2023, only one in five GCSE Computer Science and 15% of all A level Computer Science entries were from female students in England."
  end

  def build_pathway_pages
    Pathway.all.where(programme: [Programme.primary_certificate, Programme.secondary_certificate], legacy: false).includes(:programme).each do |pathway|
      path pathway_path(pathway.slug), "#{pathway.programme.certificate_name} pathway - #{pathway.title}", pathway.enrol_copy
    end
  end

  def build_curriculum_pages
    path curriculum_key_stages_path, "Teach Computing Curriculum", "Everything you need to teach computing at key stages 1 to 4"

    CurriculumClient::Queries::KeyStage.all.key_stages.each do |key_stage|
      path curriculum_key_stage_units_path(key_stage_slug: key_stage.slug), "#{key_stage.title} resources", key_stage.description

      key_stage.year_groups.each do |year_group|
        year_group_title = year_group.year_number.include?("GCSE") ? year_group.year_number : "Year #{year_group.year_number}"

        year_group.units.each do |unit|
          path curriculum_key_stage_unit_path(key_stage_slug: key_stage.slug, unit_slug: unit.slug), "#{key_stage.short_title} resources - #{year_group_title} - #{unit.title}", unit.description
        end
      end
    end

    CurriculumClient::Queries::Lesson.all.lessons.each do |lesson|
      year_group = lesson.unit.year_group
      year_group_title = year_group.year_number.include?("GCSE") ? year_group.year_number : "Year #{year_group.year_number}"

      path curriculum_key_stage_unit_lesson_path(key_stage_slug: year_group.key_stage.slug, unit_slug: lesson.unit.slug, lesson_slug: lesson.slug),
        "#{year_group.key_stage.short_title} resources - #{year_group_title} - #{lesson.unit.title} - #{lesson.title}",
        lesson.description
    end
  end
end
