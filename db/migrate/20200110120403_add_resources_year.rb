class AddResourcesYear < ActiveRecord::Migration[5.2]
  def change
    create_table :resources, id: :uuid do |t|
      t.references :user_id
      t.string :resource_year, null: false
      t.integer :counter, :default => 0
      t.timestamps
    end
  end
end
