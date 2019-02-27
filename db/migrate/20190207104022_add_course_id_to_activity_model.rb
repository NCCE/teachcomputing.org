class AddCourseIdToActivityModel < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :course_id, :string
    add_index :activities, :course_id, unique: true
  end
end
