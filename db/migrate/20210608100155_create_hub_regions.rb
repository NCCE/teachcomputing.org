class CreateHubRegions < ActiveRecord::Migration[6.1]
  def change
    create_table :hub_regions, id: :uuid do |t|
      t.string :name, null: false
      t.integer :order, null: false

      t.timestamps
    end

    add_index :hub_regions, :order, unique: true
  end
end
