class AddAutoEnrolledFlagToUserProgrammeEnrolments < ActiveRecord::Migration[5.2]
  def change
    add_column :user_programme_enrolments, :auto_enrolled, :boolean, default: false
  end
end
