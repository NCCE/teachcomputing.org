class AddObjectivesToProgrammeActivityGroupings < ActiveRecord::Migration[6.1]
  def change
    add_column :programme_activity_groupings, :objectives, :jsonb
  end
end
