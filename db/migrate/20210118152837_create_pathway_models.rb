class CreatePathwayModels < ActiveRecord::Migration[6.1]
  def change
    create_table :pathways, id: :uuid do |t|
      t.int4range :range, null: false
      t.uuid :programme_id
      t.string :title, null: false
      t.text :description

      t.timestamps
    end

    create_table :pathway_activities, id: :uuid do |t|
      t.uuid :pathway_id
      t.uuid :activity_id
      t.integer :activity_type, null: false
      t.integer :order

      t.timestamps
    end

    add_column :user_programme_enrolments, :pathway_id, :uuid, null: true
  end
end
