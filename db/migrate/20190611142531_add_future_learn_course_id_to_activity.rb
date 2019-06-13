class AddFutureLearnCourseIdToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :future_learn_course_id, :string
  end
end
