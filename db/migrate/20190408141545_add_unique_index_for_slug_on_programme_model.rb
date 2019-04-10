class AddUniqueIndexForSlugOnProgrammeModel < ActiveRecord::Migration[5.2]
  def change
    add_index :programmes, :slug, unique: true
  end
end
