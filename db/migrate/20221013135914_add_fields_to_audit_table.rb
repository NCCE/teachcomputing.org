class AddFieldsToAuditTable < ActiveRecord::Migration[6.1]
  def change
    add_column :audits, :ticket_id, :uuid, null: true
  end
end
