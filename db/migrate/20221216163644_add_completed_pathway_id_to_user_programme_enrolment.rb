class AddCompletedPathwayIdToUserProgrammeEnrolment < ActiveRecord::Migration[6.1]
  def change
    add_column :user_programme_enrolments, :completed_pathway_id, :uuid, null: true
  end
end
