class AddForgottenBooleanToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :forgotten, :boolean, default: false
  end
end
