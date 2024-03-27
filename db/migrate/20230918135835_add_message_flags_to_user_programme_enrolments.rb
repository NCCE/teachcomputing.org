class AddMessageFlagsToUserProgrammeEnrolments < ActiveRecord::Migration[6.1]
  def change
    add_column :user_programme_enrolments, :message_flags, :jsonb
  end
end
