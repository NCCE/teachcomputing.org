class RemoveAchieverOrganisationNoFromUserModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :stem_achiever_organisation_no, :string
  end
end
