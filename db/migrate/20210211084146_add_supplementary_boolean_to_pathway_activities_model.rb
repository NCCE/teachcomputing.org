class AddSupplementaryBooleanToPathwayActivitiesModel < ActiveRecord::Migration[6.1]
  def change
    add_column :pathway_activities, :supplementary, :boolean, default: false
  end
end
