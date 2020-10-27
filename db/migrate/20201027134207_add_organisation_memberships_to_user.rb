class AddOrganisationMembershipsToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :future_learn_organisation_memberships, :text, array: true, default: []

    query = <<~SQL
      UPDATE
        users
      SET
        future_learn_organisation_memberships = ARRAY [ future_learn_organisation_membership_uuid ]
      WHERE
        future_learn_organisation_membership_uuid IS NOT NULL;
    SQL
    execute query
    remove_index :users, :future_learn_organisation_membership_uuid
    remove_column :users, :future_learn_organisation_membership_uuid
  end

  def down
    add_column :users, :future_learn_organisation_membership_uuid, :uuid
    add_index :users, :future_learn_organisation_membership_uuid, unique: true
    query = <<~SQL
      UPDATE
        users
      SET
        future_learn_organisation_membership_uuid = CAST (future_learn_organisation_memberships [1] as uuid)
      WHERE
        future_learn_organisation_memberships [1] IS NOT NULL;
    SQL
    execute query
    remove_column :users, :future_learn_organisation_memberships
  end
end
