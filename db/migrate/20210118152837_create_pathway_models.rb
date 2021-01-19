class CreatePathwayModels < ActiveRecord::Migration[6.1]
  def change
    create_table :pathways, id: :uuid do |t|
      t.int4range :range
      t.uuid :programme_id
      t.string :title
      t.text :description

      t.timestamps
    end

    create_table :pathway_activities, id: :uuid do |t|
      t.uuid :pathway_id
      t.uuid :activity_id
      t.boolean :supplemental
      t.integer :order

      t.timestamps
    end

    add_column :user_programme_enrolments, :pathway_id, :uuid, optional: true
  end
end
