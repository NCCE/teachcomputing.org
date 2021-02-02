class CreateAchieverSyncRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :achiever_sync_records, id: :uuid do |t|
      t.string :state, null: false
      t.references :user_programme_enrolment, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
