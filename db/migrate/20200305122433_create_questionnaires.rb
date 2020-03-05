class CreateQuestionnaires < ActiveRecord::Migration[5.2]
  def change
    create_table :questionnaires, id: :uuid do |t|
      t.uuid :programme_id
      t.string :title
      t.string :slug
      t.text :description

      t.timestamps
    end
    add_index :questionnaires, :programme_id
    add_index :questionnaires, :slug, unique: true
  end
end
