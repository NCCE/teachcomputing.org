class AddCourseIdToActivityModel < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :course_id, :string, index: true
  end
end
