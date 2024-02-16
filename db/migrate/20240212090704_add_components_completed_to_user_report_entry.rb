class AddComponentsCompletedToUserReportEntry < ActiveRecord::Migration[6.1]
  def change
    add_column :user_report_entries, :completed_first_community_component, :boolean, null: false, default: false
    add_column :user_report_entries, :completed_second_community_component, :boolean, null: false, default: false
  end
end
