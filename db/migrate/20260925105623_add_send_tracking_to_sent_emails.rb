class AddSendTrackingToSentEmails < ActiveRecord::Migration[8.1]
  def change
    add_column :sent_emails, :send_count, :integer, null: false, default: 0
    add_column :sent_emails, :last_sent_at, :datetime
  end
end
