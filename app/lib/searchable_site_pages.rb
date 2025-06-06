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

    path accessibility_statement_path, "Accessibility statement", "We are committed to making our website more accessible and inclusive for everyone. This is an important part of our aim to ensure that everyone who visits the National Centre for Computing Education website feels welcome."
    path competition_terms_and_conditions_path, "Prize draws and competitions", "From time to time, we may run prize draws and/or competitions on our site. For each prize draw and/or competition, the following terms will also apply."
    path about_isaac_computer_science_path, "Isaac Computer Science", "Access a huge range of time-saving learning materials that cover the full A level and GCSE Computer Science curricula for the AQA, OCR, Edexcel, and Eduqas exam specifications — all for free!"
    path impact_path, "Impact, evaluation and research", "Our vision is for every child in every school in England to have a world-leading computing education. We continually evaluate the impact that our programmes, services and resources are having on improving the quality of teaching computing in schools, and the learning experience for young people."

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
    # path curriculum_key_stages_path, "Teach Computing Curriculum", "Everything you need to teach computing at key stages 1 to 4"

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
