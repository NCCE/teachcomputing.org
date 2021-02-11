class AddPdfLinkToPathwayModel < ActiveRecord::Migration[6.1]
  def change
    add_column :pathways, :pdf_link, :string, null: true
  end
end
