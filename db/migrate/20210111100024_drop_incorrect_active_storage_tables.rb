class DropIncorrectActiveStorageTables < ActiveRecord::Migration[6.1]
  def up
    drop_table :active_storage_variant_records
    drop_table :active_storage_attachments
    drop_table :active_storage_blobs
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
