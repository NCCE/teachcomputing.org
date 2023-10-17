class AddSchoolToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :school, :string
  end
end
