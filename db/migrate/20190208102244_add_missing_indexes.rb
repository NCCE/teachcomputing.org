class AddMissingIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :activities, :category
  end
end
