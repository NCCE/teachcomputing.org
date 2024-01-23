class AddPendingToUserReportEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :user_report_entries, :pending_certificate, :boolean, null: false, default: false
  end
end
