class AddProgrammeIdToAchievement < ActiveRecord::Migration[5.2]
  def change
    add_column :achievements, :programme_id, :uuid, null: true
    add_index :achievements, [:programme_id, :user_id], unique: false
    add_index :achievements, [:activity_id, :user_id], unique: true
  end
end
