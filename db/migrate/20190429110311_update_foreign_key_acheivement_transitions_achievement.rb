class UpdateForeignKeyAcheivementTransitionsAchievement < ActiveRecord::Migration[5.2]
  def change
    # remove the old foreign_key
    remove_foreign_key :achievement_transitions, :achievements

    # add the new foreign_key
    add_foreign_key :achievement_transitions, :achievements, on_delete: :cascade
  end
end
