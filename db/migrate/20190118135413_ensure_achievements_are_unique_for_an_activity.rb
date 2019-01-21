class EnsureAchievementsAreUniqueForAnActivity < ActiveRecord::Migration[5.2]
  def change
    remove_index :achievements, :activity_id
    remove_index :achievements, :user_id
    add_index :achievements, :activity_id, unique: true
    add_index :achievements, :user_id, unique: true
  end
end
