class AddLegacyFlagToPathways < ActiveRecord::Migration[6.1]
  def change
    add_column :pathways, :legacy, :boolean, default: false
  end
end
