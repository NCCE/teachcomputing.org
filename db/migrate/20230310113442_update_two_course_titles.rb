class UpdateTwoCourseTitles < ActiveRecord::Migration[6.1]
  def up
    # CP463
    Activity
      .find_by(stem_course_template_no: 'e1e54959-db12-eb11-a813-000d3a86d545')
      .update(title: 'Python programming: advanced subject knowledge, implementation and testing - remote')
    # CP464
    Activity
      .find_by(stem_course_template_no: 'ad8580c0-2915-eb11-a813-000d3a86f6ce')
      .update(title: 'Python programming: analysis, design and evaluation - remote')
  end

  def down
    # CP463
    Activity
      .find_by(stem_course_template_no: 'e1e54959-db12-eb11-a813-000d3a86d545')
      .update(title: 'Python programming projects - advanced subject knowledge, implementation and testing a program - Remote')
    # CP464
    Activity
      .find_by(stem_course_template_no: 'ad8580c0-2915-eb11-a813-000d3a86f6ce')
      .update(title: 'Python programming projects - analysing, designing and evaluating a program - Remote')
  end
end
