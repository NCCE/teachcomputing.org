class AddTriggerTypeToBadge < ActiveRecord::Migration[6.1]
  def change
    add_column :badges, :trigger_type, :integer, default: 0
  end
end
