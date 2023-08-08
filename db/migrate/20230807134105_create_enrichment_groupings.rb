class CreateEnrichmentGroupings < ActiveRecord::Migration[6.1]
  def change
    create_table :enrichment_groupings, id: :uuid do |t|
      t.belongs_to :programme, forign_key: true

      t.string :type
      t.string :title
      t.datetime :term_start
      t.datetime :term_end

      t.timestamps
    end
  end
end
