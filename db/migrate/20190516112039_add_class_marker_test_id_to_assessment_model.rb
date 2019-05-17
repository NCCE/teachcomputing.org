class AddClassMarkerTestIdToAssessmentModel < ActiveRecord::Migration[5.2]
  def change
    add_column :assessments, :class_marker_test_id, :string
  end
end
