class AddWebCopyToProgrammes < ActiveRecord::Migration[6.1]
  def change
    add_column :programmes, :web_copy, :jsonb
  end
end
