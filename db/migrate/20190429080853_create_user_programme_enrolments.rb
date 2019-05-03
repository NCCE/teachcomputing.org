class CreateUserProgrammeEnrolments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_programme_enrolments, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, index: true
      t.references :programme, type: :uuid, null: false, index: true
      t.timestamps
    end
  end
end
