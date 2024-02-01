class CreateUserReportEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :user_report_entries, id: :uuid do |t|
      t.string :programme_slug, null: false
      t.string :user_email, null: false
      t.string :user_stem_user_id, null: false
      t.boolean :user_enrolled, default: false, null: false
      t.datetime :enrolled_at
      t.datetime :last_active_at
      t.boolean :completed_cpd_component, default: false, null: false
      t.boolean :completed_certificate, default: false, null: false

      t.timestamps
    end
  end
end
