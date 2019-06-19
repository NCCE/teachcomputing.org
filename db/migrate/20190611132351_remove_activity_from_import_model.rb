class RemoveActivityFromImportModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :imports, :activity_id, :references
  end
end
