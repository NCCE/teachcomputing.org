class RemoveNotNullConstraintOnAssessment < ActiveRecord::Migration[6.1]
  def change
    change_column_null :assessments, :activity_id, true
  end
end
