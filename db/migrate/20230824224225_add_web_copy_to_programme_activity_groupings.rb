class AddWebCopyToProgrammeActivityGroupings < ActiveRecord::Migration[6.1]
  def change
    add_column :programme_activity_groupings, :web_copy, :jsonb
  end
end
