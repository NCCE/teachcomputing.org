class CreateHubs < ActiveRecord::Migration[6.1]
  def change
    create_table :hubs, id: :uuid do |t|
      t.string :name, null: false
      t.references :hub_region, null: false, foreign_key: true, type: :uuid
      t.uuid :subdeliverer_id, null: false
      t.string :address
      t.string :postcode
      t.string :email
      t.string :phone
      t.string :website
      t.string :twitter
      t.string :facebook
      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_index :hubs, [:latitude, :longitude]
  end
end
