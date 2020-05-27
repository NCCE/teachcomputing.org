class AddUniqueIndexesToActivity < ActiveRecord::Migration[5.2]
  def change
    add_index :activities, :future_learn_course_uuid, unique: true
  end
end
