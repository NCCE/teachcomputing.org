class AddProgressBarTitleToProgrammeActivityGroupings < ActiveRecord::Migration[6.1]
  def change
    add_column :programme_activity_groupings, :progress_bar_title, :string
  end
end
