class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers, id: :uuid do |t|
      t.string :text
      t.string :label
      t.boolean :correct
      t.references :question, type: :uuid, null: false

      t.timestamps
    end
  end
end
