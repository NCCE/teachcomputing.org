class AddLegacyToProgrammeActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :programme_activities, :legacy, :boolean, default: false, null: false
  end
end
