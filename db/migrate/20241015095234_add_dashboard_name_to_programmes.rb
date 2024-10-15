class AddDashboardNameToProgrammes < ActiveRecord::Migration[6.1]
  def change
    add_column :programmes, :dashboard_name, :string
  end
end
