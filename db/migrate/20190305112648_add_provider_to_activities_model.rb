class AddProviderToActivitiesModel < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :provider, :string
  end
end
