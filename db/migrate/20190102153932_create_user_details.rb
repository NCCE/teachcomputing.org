class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details, id: :uuid do |t|
      t.datetime :last_sign_in_at
      t.string :stem_user_id
      t.string :stem_achiever_contact_no
      t.string :stem_credentials_access_token
      t.string :stem_credentials_refresh_token
      t.string :stem_credentials_expires_at
      t.timestamps
      t.index ["stem_user_id"], name: "index_users_on_stem_user_id", unique: true
    end
  end
end
