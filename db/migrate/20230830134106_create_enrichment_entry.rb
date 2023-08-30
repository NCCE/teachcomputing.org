class CreateEnrichmentEntry < ActiveRecord::Migration[6.1]
  def change
    create_table :enrichment_entries, id: :uuid do |t|
      t.belongs_to :enrichment_grouping, foreign_key: true, type: :uuid

      t.string :title
      t.string :title_url
      t.string :image_url
      t.string :body
      t.boolean :published

      t.timestamps
    end
  end
end
