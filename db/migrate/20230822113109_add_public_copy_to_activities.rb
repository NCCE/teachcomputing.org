class AddPublicCopyToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :public_copy, :jsonb
  end
end
