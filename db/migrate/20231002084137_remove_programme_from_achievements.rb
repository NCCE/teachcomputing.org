class RemoveProgrammeFromAchievements < ActiveRecord::Migration[6.1]
  def up
    remove_index :achievements, column: %i[programme_id user_id], name: 'index_achievements_on_programme_id_and_user_id'
    remove_belongs_to :achievements, :programme, index: false
  end

  def down
    add_belongs_to :achievements, :programme, index: false, type: :uuid
    add_index :achievements, %i[programme_id user_id]
  end
end
