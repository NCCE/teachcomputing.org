class CreateQuestionnaires < ActiveRecord::Migration[5.2]
  def change
    create_table :questionnaires, id: :uuid do |t|
      t.references :programme, type: :uuid, null: false, index: true
      t.string :title
      t.string :slug
      t.text :description

      t.timestamps
    end
    add_index :questionnaires, :slug, unique: true
  end
end
