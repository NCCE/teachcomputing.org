class AddOrganisationMembershipToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :future_learn_organisation_membership_uuid, :uuid
    add_index :users, :future_learn_organisation_membership_uuid, unique: true
  end
end
