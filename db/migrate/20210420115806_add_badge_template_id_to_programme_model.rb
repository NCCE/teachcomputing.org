class AddBadgeTemplateIdToProgrammeModel < ActiveRecord::Migration[6.1]
  def change
    add_column :programmes, :credly_badge_template_id, :string, null: true
  end
end
