class RemoveUniquenessConstraintsforUserAndActivityOnAchievements < ActiveRecord::Migration[5.2]
  def change
    remove_index :achievements, :activity_id
    remove_index :achievements, :user_id
  end
end
