class AddSlugToPathways < ActiveRecord::Migration[6.1]
  def change
    add_column :pathways, :slug, :string, null: false
    add_index :pathways, :slug, unique: true
  end
end
