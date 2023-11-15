class AddIBelongToEnrichmentEntry < ActiveRecord::Migration[6.1]
  def change
    add_column :enrichment_entries, :i_belong, :boolean
  end
end
