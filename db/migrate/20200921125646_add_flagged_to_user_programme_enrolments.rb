class AddFlaggedToUserProgrammeEnrolments < ActiveRecord::Migration[5.2]
  def change
    add_column :user_programme_enrolments, :flagged, :boolean, default: false
  end
end
