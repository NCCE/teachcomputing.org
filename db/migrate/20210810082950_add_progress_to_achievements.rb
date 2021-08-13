class AddProgressToAchievements < ActiveRecord::Migration[6.1]
  def change
    add_column :achievements, :progress, :int4, null: false, default: 0
  end
end
