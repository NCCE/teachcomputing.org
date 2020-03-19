class UpdateQuestionnaireResponseDefaults < ActiveRecord::Migration[5.2]
  def change
    change_column_default :questionnaire_responses, :current_question, from: 0, to: 1
    change_column_default :questionnaire_responses, :answers, {}
  end
end
