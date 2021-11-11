class AddAlwaysOnToActivity < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :always_on, :boolean, default: false
  end
end
