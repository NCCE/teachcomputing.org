class RemoveOrderFromPathwayActivity < ActiveRecord::Migration[6.1]
  def change
    remove_column :pathway_activities, :order
  end
end
