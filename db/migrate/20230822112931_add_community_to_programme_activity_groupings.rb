class AddCommunityToProgrammeActivityGroupings < ActiveRecord::Migration[6.1]
  def change
    add_column :programme_activity_groupings, :community, :boolean, default: false
  end
end
