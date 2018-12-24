class User

  include UserDetailable
  attr_reader :id, :first_name, :last_name, :email, :stem_achiever_contact_no, :stem_credentials_access_token, :stem_credentials_refresh_token, :stem_credentials_expires_at

  def initialize(id, first_name, last_name, email, achiever_contact_no, access_token, refresh_token, expires_at)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @stem_achiever_contact_no = achiever_contact_no
    @stem_credentials_access_token = access_token
    @stem_credentials_refresh_token = refresh_token
    @stem_credentials_expires_at = expires_at
  end

  def self.from_auth(id, credentials, info)
    new(id, info.first_name, info.last_name, info.email, info.achiever_contact_no, credentials.token, credentials.refresh_token, credentials.expires_at)
  end

  def self.from_session(session)
    return nil unless session
    new(session['id'], session['first_name'], session['last_name'], session['email'], session['stem_achiever_contact_no'], session['stem_credentials_access_token'], session['stem_credentials_refresh_token'], session['stem_credentials_expires_at'])
  end

  def update_last_sign_in_at!
    details.update(last_sign_in_at: Time.current)
  end
end
