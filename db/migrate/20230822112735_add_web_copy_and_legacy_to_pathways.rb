class AddWebCopyAndLegacyToPathways < ActiveRecord::Migration[6.1]
  def change
    add_column :pathways, :web_copy, :jsonb
    add_column :pathways, :legacy, :boolean, default: false, null: false
  end
end
