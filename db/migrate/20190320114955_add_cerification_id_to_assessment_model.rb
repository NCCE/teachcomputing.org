class AddCerificationIdToAssessmentModel < ActiveRecord::Migration[5.2]
  def change
    add_reference :assessments, :certification
  end
end
