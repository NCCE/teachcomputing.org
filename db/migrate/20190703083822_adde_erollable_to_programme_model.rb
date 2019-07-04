class AddeErollableToProgrammeModel < ActiveRecord::Migration[5.2]
  def change
    add_column :programmes, :enrollable, :boolean, default: false
  end
end
