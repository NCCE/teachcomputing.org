class AddAffectedUserIdToAudits < ActiveRecord::Migration[6.1]
  def change
    add_column :audits, :affected_user_id, :uuid, null: true
  end
end
