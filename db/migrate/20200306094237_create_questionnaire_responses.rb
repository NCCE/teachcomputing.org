class CreateQuestionnaireResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :questionnaire_responses, id: :uuid do |t|
      t.references :questionnaire, type: :uuid, null: false
      t.references :user, type: :uuid, null: false
      t.references :programme, type: :uuid, null: false
      t.integer :current_question, default: 0
      t.json :answers

      t.timestamps
    end
    add_index :questionnaire_responses, [:programme_id, :user_id], unique: true
  end
end
