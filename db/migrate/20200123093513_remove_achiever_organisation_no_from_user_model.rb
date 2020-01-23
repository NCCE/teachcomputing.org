class RemoveAchieverOrganisationNoFromUserModel < ActiveRecord::Migration[5.2]
  def change
    drop_column :users, :stem_achiever_organisation_no, :string
  end
end
