class AddOrderToEnrichmentEntry < ActiveRecord::Migration[6.1]
  def change
    add_column :enrichment_entries, :order, :integer
  end
end
