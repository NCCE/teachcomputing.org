class AddMultiStageGroupToProgrammeActivityGroupings < ActiveRecord::Migration[6.1]
  def change
    add_column :programme_activity_groupings, :multi_stage_group, :boolean, default: false, null: false
  end
end
