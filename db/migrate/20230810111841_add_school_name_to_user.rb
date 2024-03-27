class AddSchoolNameToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :school_name, :string, null: true
  end
end
