class AddDurationInHoursToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :duration_in_hours, :float
  end
end
