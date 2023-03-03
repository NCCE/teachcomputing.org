class StemAchieverContactNoChangeColumnType < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :stem_achiever_contact_no, 'uuid USING CAST(stem_achiever_contact_no AS uuid)'
  end

  def down
    change_column :users, :stem_achiever_contact_no, :string
  end
end
