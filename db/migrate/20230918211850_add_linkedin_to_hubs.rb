class AddLinkedinToHubs < ActiveRecord::Migration[6.1]
  def change
    add_column :hubs, :linkedin, :string
  end
end
