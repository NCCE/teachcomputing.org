class CreateEnrichmentGroupings < ActiveRecord::Migration[6.1]
  def change
    create_table :enrichment_groupings, id: :uuid do |t|
      t.belongs_to :programme, foreign_key: true, type: :uuid

      t.string :type
      t.string :title
      t.datetime :term_start
      t.datetime :term_end
      t.boolean :published
      t.boolean :coming_soon

      t.timestamps
    end
  end
end
