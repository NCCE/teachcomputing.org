class AddAttrEncryptedFieldsToUserDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :user_details, :encrypted_stem_credentials_access_token, :string
    add_column :user_details, :encrypted_stem_credentials_access_token_iv, :string
    add_column :user_details, :encrypted_stem_credentials_refresh_token, :string
    add_column :user_details, :encrypted_stem_credentials_refresh_token_iv, :string
  end
end
