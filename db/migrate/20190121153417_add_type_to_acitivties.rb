class AddTypeToAcitivties < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :category, :string, index: true
  end
end
