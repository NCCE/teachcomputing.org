class UserDetail < ApplicationRecord
  validates :stem_user_id, uniqueness: true
  attr_encrypted :stem_credentials_access_token, key: ENV.fetch('STEM_CREDENTIALS_ACCESS_TOKEN_KEY')
  attr_encrypted :stem_credentials_refresh_token, key: ENV.fetch('STEM_CREDENTIALS_REFRESH_TOKEN_KEY')
end
