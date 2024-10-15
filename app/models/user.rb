require "audited"

# #school_name is the school or college name to print onto the I Belong certificate PDF
class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :stem_achiever_contact_no, presence: true
  validates :stem_credentials_access_token, presence: true
  # validates :stem_credentials_refresh_token, presence: true
  validates :stem_credentials_expires_at, presence: true
  validates :stem_user_id, presence: true, uniqueness: true
  # WARNING: We are consiously choosing not to have a unique constraint on
  # emails
  validates :email, presence: true
  validates :teacher_reference_number, uniqueness: true, if: proc { |u| u.teacher_reference_number.present? }

  attr_encrypted :stem_credentials_access_token, key: Rails.application.config.stem_credentials_access_token
  attr_encrypted :stem_credentials_refresh_token, key: Rails.application.config.stem_credentials_refresh_token

  has_many :achievements, dependent: :restrict_with_exception
  has_many :activities, through: :achievements
  has_many :assessment_attempts, dependent: :destroy
  has_many :feedback_comments, dependent: :restrict_with_exception
  has_many :user_programme_enrolments, dependent: :restrict_with_exception
  has_many :programmes, through: :user_programme_enrolments
  has_many :resource_users, dependent: :nullify
  has_many :questionnaire_response, dependent: :nullify
  has_many :sent_emails

  after_create :schedule_fetching_of_course_bookings

  scope :without_forgotten, -> { where(forgotten: false) }
  scope :enrolled_in_programme, ->(programme) { joins(:user_programme_enrollment).where(user_programme_enrollment: {programme:}) }

  audited only: %i[first_name last_name stem_achiever_contact_no stem_user_id], on: :update, comment_required: false
  alias_attribute :support_audits, :audits

  def self.from_auth(id, credentials, info)
    user = where(stem_user_id: info.stem_user_id).first_or_initialize

    users_with_new_email_count = User.where(email: info.email.downcase).count

    if user.persisted?
      if user.email == info.email.downcase
        Sentry.capture_message("User #{user.email}-#{id} logged in with duplicate email", level: :log) if users_with_new_email_count >= 2
      elsif users_with_new_email_count >= 1
        Sentry.capture_message("User #{user.email}-#{id} logged renaming to duplicated email #{info.email.downcase}", level: :warning)
      end
    elsif users_with_new_email_count >= 1
      Sentry.capture_message("User #{id} created with duplicated email #{info.email.downcase}", level: :warning)
    end

    user.auth0_id = id
    user.stem_user_id = info.stem_user_id
    user.first_name = info.first_name
    user.last_name = info.last_name
    user.email = info.email.downcase
    user.stem_achiever_contact_no = info.achiever_contact_no
    user.stem_credentials_access_token = credentials.token
    user.stem_credentials_refresh_token = credentials.refresh_token
    user.stem_credentials_expires_at = Time.zone.at(credentials.expires_at)
    user.stem_achiever_organisation_no = info.achiever_organisation_no
    user.last_sign_in_at = Time.current
    user.school_name = info.school_name

    user.save!

    user
  end

  def enrolments
    user_programme_enrolments
  end

  def enrolled_on_programme_pathway?(programme:, pathway:)
    enrolment = user_programme_enrolments.find_by(programme:, pathway:)
    return false if enrolment.blank?

    !enrolment.in_state?(:unenrolled)
  end

  def programme_enrolment_state(programme_id)
    enrolment = user_programme_enrolments.find_by(programme_id:)
    return "Not enrolled" unless enrolment

    enrolment.current_state
  end

  def on_programme_pathway?(programme)
    programme_pathway(programme).present?
  end

  def programme_pathway(programme)
    enrolment = user_programme_enrolments.find_by(programme:)
    enrolment&.pathway
  end

  def schedule_fetching_of_course_bookings
    Achiever::FetchUsersCompletedCoursesFromAchieverJob.perform_later(self)
  end

  def forget!
    return if forgotten

    attributes.each do |name, _value|
      next if %w[id created_at updated_at].include?(name) || name.match(/_token/)

      self[name] = case name.to_sym
      when :email
        "#{id}@devnull-ncce.slcs.ac.uk"
      when :stem_credentials_expires_at
        DateTime.now
      when :future_learn_organisation_memberships
        []
      when :forgotten
        true
      when :last_sign_in_at
        nil
      else
        id
      end
    end

    self.stem_credentials_access_token = SecureRandom.hex(8)
    self.stem_credentials_refresh_token = SecureRandom.hex(8)

    achievements_with_attachments = achievements.with_attachments
    achievements_with_attachments.each do |achievement|
      achievement.supporting_evidence.purge
    end

    save!
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
