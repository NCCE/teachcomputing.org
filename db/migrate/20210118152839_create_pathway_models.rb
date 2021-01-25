class CreatePathwayModels < ActiveRecord::Migration[6.1]
  def change
    create_table :pathways, id: :uuid do |t|
      t.int4range :range, null: false
      t.string :title, null: false
      t.text :description

      t.timestamps
    end

    create_table :pathway_activities, id: :uuid do |t|
      t.references :pathway, null: false, foreign_key: true, type: :uuid
      t.references :activity, null: false, foreign_key: true, type: :uuid
      t.integer :activity_type, null: false
      t.integer :order

      t.timestamps
    end

    add_reference :user_programme_enrolments, :pathway, foreign_key: true, type: :uuid
  end
end
