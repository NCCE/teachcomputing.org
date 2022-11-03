class AddAcceptedConditionsToAssessmentAttempt < ActiveRecord::Migration[6.1]
  def change
    add_column :assessment_attempts, :accepted_conditions, :boolean, null: true
  end
end
