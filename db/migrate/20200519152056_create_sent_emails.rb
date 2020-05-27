class CreateSentEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :sent_emails, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, index: true
      t.string :mailer_type, null: false
      t.string :subject, null: false

      t.timestamps
    end

    add_index :sent_emails, [:user_id, :mailer_type], unique: true, name: :index_one_mailer_type_per_user
  end
end
