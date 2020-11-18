class AddUploadAbleFieldToActivityModel < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :uploadable, :boolean, default: false
  end
end
