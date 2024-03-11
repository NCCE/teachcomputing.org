class AddInstagramToHubs < ActiveRecord::Migration[6.1]
  def change
    add_column :hubs, :instagram, :string
  end
end
