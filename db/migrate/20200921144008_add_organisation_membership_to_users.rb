class AddOrganisationMembershipToUsers < ActiveRecord::Migration[5.2]
  def change
	add_index :users, :future_learn_organisation_membership_uuid, unique: false, type: :uuid
  end
end
