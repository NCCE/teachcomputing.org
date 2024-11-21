class AddAuth0IdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :auth0_id, :string, default: nil
  end
end
