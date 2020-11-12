class CreateProgrammeActivityGroupings < ActiveRecord::Migration[5.2]
  def change
    create_table :programme_activity_groupings, id: :uuid do |t|
      t.string :title
      t.integer :sort_key
      t.integer :required_for_completion
      t.references :programme, type: :uuid, null: false, index: true

      t.timestamps
    end
    add_column :programme_activities, :programme_activity_grouping_id, :uuid, null: true
  end
end
