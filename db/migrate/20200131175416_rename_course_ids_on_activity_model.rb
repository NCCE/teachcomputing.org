class RenameCourseIdsOnActivityModel < ActiveRecord::Migration[5.2]
  def change
    rename_column :activities, :stem_course_id, :stem_course_template_no
    rename_column :activities, :future_learn_course_id, :future_learn_course_uuid
  end
end
