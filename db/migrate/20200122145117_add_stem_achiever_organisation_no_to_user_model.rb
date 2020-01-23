class AddStemAchieverOrganisationNoToUserModel < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stem_achiever_organisation_no, :string
  end
end
