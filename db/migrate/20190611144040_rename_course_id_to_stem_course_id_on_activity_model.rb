class RenameCourseIdToStemCourseIdOnActivityModel < ActiveRecord::Migration[5.2]
  def change
    rename_column :activities, :course_id, :stem_course_id
  end
end
