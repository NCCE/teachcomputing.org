class AddCredlyBadgeTemplateIdsToProgrammes < ActiveRecord::Migration[6.1]
  def change
    add_column :programmes, :credly_badge_template_ids, :text, array: true, default: []
  end
end
