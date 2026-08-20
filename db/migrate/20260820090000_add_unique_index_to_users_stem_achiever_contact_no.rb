class AddUniqueIndexToUsersStemAchieverContactNo < ActiveRecord::Migration[8.1]
  def change
    add_index :users, :stem_achiever_contact_no, unique: true
  end
end
