class RemoveProgrammeFromQuestionnaireResponse < ActiveRecord::Migration[6.1]
  def up
    remove_index :questionnaire_responses, %i[programme_id user_id questionnaire_id],
      unique: true,
      name: :index_one_questionnaire_per_user
    remove_column :questionnaire_responses, :programme_id

    add_index :questionnaire_responses, %i[user_id questionnaire_id], unique: true,
      name: :index_one_questionnaire_per_user
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
