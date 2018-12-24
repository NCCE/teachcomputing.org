require 'active_support/concern'

module UserDetailable
  extend ActiveSupport::Concern

  def details
    UserDetail.find_or_create_by(stem_user_id: id,
                                 stem_achiever_contact_no: stem_achiever_contact_no,
                                 stem_credentials_access_token: stem_credentials_access_token,
                                 stem_credentials_refresh_token: stem_credentials_refresh_token,
                                 stem_credentials_expires_at: stem_credentials_expires_at)
  end

end
