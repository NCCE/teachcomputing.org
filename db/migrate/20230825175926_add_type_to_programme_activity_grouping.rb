class AddTypeToProgrammeActivityGrouping < ActiveRecord::Migration[6.1]
  def change
    add_column :programme_activity_groupings, :type, :string
  end
end
