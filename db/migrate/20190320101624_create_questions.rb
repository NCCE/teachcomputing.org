class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions, id: :uuid do |t|
      t.text :text
      t.string :difficulty
      t.references :category, type: :uuid, null: false

      t.timestamps
    end
  end
end
