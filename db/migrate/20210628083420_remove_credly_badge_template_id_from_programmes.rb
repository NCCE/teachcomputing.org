class RemoveCredlyBadgeTemplateIdFromProgrammes < ActiveRecord::Migration[6.1]
  def change
    remove_column :programmes, :credly_badge_template_id
  end
end
