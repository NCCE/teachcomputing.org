class AddSlugToActivityModel < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :slug, :string
    add_index :activities, :slug, unique: true
  end
end
