class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges, id: :uuid do |t|
      t.references :programme, null: false, foreign_key: true, type: :uuid
      t.boolean :active, default: false
      t.string :academic_year, null: false
      t.uuid :credly_badge_template_id, null: false
      t.timestamps
    end
  end
end
