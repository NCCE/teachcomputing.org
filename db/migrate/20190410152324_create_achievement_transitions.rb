class CreateAchievementTransitions < ActiveRecord::Migration[5.2]
  def change
    create_table :achievement_transitions do |t|
      t.string :to_state, null: false
      # https://github.com/gocardless/statesman/issues/313#issue-303992330
      t.json :metadata, default: {}
      t.integer :sort_key, null: false
      t.uuid :achievement_id, null: false
      t.boolean :most_recent, null: false

      t.timestamps null: false
    end

    # Foreign keys are optional, but highly recommended
    add_foreign_key :achievement_transitions, :achievements

    add_index(:achievement_transitions,
      %i[achievement_id sort_key],
      unique: true,
      name: "index_achievement_transitions_parent_sort")
    add_index(:achievement_transitions,
      %i[achievement_id most_recent],
      unique: true,
      where: "most_recent",
      name: "index_achievement_transitions_parent_most_recent")
  end
end
