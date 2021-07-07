class AddSatelliteToHubs < ActiveRecord::Migration[6.1]
  def change
    add_column :hubs, :satellite, :boolean, default: false
    add_column :hubs, :satellite_info, :string
  end
end
