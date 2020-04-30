class RemoveUniqueSlugIndexOnActivities < ActiveRecord::Migration[5.2]
  def change
    remove_index :activities, :slug
  end
end
