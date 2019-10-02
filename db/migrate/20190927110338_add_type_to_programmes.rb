class AddTypeToProgrammes < ActiveRecord::Migration[5.2]
  def change
    add_column :programmes, :type, :string
  end
end
