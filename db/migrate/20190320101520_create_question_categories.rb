class CreateQuestionCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :question_categories, id: :uuid do |t|
      t.string :title
      t.string :slug

      t.timestamps
    end
  end
end
