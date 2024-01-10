class AddResourcesYear < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_users, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, index: true
      t.integer :resource_year, null: false
      t.integer :counter, default: 0
      t.timestamps
    end
    add_index :resource_users, [:user_id, :resource_year], unique: true, name: "resource_year_user"
  end
end
