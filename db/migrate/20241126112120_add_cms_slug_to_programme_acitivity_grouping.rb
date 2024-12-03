class AddCmsSlugToProgrammeAcitivityGrouping < ActiveRecord::Migration[6.1]
  def change
    add_column :programme_activity_groupings, :cms_slug, :string
    add_index :programme_activity_groupings, :cms_slug, unique: true
  end
end
