class RemoveActivityTypeFromPathwayActivities < ActiveRecord::Migration[6.1]
  def change
    remove_column :pathway_activities, :activity_type
  end
end
