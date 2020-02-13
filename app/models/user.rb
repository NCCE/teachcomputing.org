class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :stem_achiever_contact_no, presence: true
  validates :stem_credentials_access_token, presence: true
  validates :stem_credentials_refresh_token, presence: true
  validates :stem_credentials_expires_at, presence: true
  validates :stem_user_id, presence: true
  validates :stem_user_id, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :teacher_reference_number, uniqueness: true,
                                       if: proc { |u| u.teacher_reference_number.present? }

  attr_encrypted :stem_credentials_access_token, key: ENV.fetch('STEM_CREDENTIALS_ACCESS_TOKEN_KEY')
  attr_encrypted :stem_credentials_refresh_token, key: ENV.fetch('STEM_CREDENTIALS_REFRESH_TOKEN_KEY')

  has_many :achievements, dependent: :restrict_with_exception
  has_many :activities, through: :achievements
  has_many :assessment_attempts, dependent: :destroy
  has_many :user_programme_enrolments, dependent: :restrict_with_exception
  has_many :programmes, through: :user_programme_enrolments
  has_many :resource_users

  after_commit :set_registered_with_ncce_achievement, on: :create

  def self.from_auth(id, credentials, info)
    where(stem_user_id: id).first_or_initialize.tap do |user|
      user.stem_user_id = id
      user.first_name = info.first_name
      user.last_name = info.last_name
      user.email = info.email.downcase
      user.stem_achiever_contact_no = info.achiever_contact_no
      user.stem_credentials_access_token = credentials.token
      user.stem_credentials_refresh_token = credentials.refresh_token
      user.stem_credentials_expires_at = Time.zone.at(credentials.expires_at)
      user.stem_achiever_organisation_no = info.achiever_organisation_no
      user.last_sign_in_at = Time.current
      user.save!
    end
  end

  def set_registered_with_ncce_achievement
    achievement = Achievement.create(user_id: id,
                                     activity_id: Activity.registered_with_the_national_centre.id)
    achievement.set_to_complete
  end
end
