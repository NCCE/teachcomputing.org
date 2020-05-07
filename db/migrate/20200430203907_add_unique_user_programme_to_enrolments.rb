class AddUniqueUserProgrammeToEnrolments < ActiveRecord::Migration[5.2]
  def change
    add_index :user_programme_enrolments, [:programme_id, :user_id], unique: true, name: :unique_programme_per_user
  end
end
