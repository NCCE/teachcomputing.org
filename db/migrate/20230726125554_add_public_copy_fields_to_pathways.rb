class AddPublicCopyFieldsToPathways < ActiveRecord::Migration[6.1]
  def change
    add_column :pathways, :web_copy, :jsonb
  end
end
