class AddComingSoonToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :coming_soon, :boolean, default: false
  end
end
