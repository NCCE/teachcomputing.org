class AddRetiredToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :retired, :boolean, default: false
  end
end
