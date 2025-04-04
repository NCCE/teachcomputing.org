class Programme < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :programme_activities, dependent: :destroy
  has_many :activities, through: :programme_activities
  has_many :user_programme_enrolments, dependent: :restrict_with_exception
  has_many :users, through: :user_programme_enrolments
  has_many :programme_activity_groupings
  has_one :assessment, dependent: :destroy
  has_one :programme_complete_counter, dependent: :destroy
  has_many :achievements, dependent: :nullify
  has_many :questionnaires, dependent: :nullify
  has_many :pathways, dependent: :nullify
  has_many :badges
  has_many :enrichment_groupings

  validates :title, :description, :slug, presence: true

  scope :enrollable, -> { where(enrollable: true) }

  def self.cs_accelerator
    Programme.find_by(slug: "subject-knowledge")
  end

  def self.primary_certificate
    Programme.find_by(slug: "primary-certificate")
  end

  def self.secondary_certificate
    Programme.find_by(slug: "secondary-certificate")
  end

  def self.i_belong
    Programme.find_by(slug: "i-belong")
  end

  def self.a_level
    Programme.find_by(slug: "a-level-certificate")
  end

  def certificate_name
    raise NotImplementedError
  end

  def include_in_filter?
    true
  end

  def pending_delay
  end

  def cpd_badge
    badges.cpd.active.first
  end

  def completion_badge
    badges.completion.active.first
  end

  def mailer
    raise NotImplementedError
  end

  def enough_activities_for_test?(_user)
    false
  end

  def show_notification_for_test?(user)
    false
  end

  def user_completed?(user)
    enrolment = user.user_programme_enrolments.find_by(programme_id: id)
    return false if enrolment.nil?

    enrolment.in_state?(:complete)
  end

  def user_meets_completion_requirement?(user)
    programme_objectives.all? { |group| group.user_complete?(user) }
  end

  def user_has_f2f_achievement?(user)
    user
      .achievements
      .in_state(:complete)
      .with_category(Activity::FACE_TO_FACE_CATEGORY)
      .belonging_to_programme(self)
      .count >= 1
  end

  def user_enrolled?(user)
    return false if user.nil?

    enrolment = user_programme_enrolments.find_by(user_id: user.id)
    enrolment.present? && !enrolment.in_state?(:unenrolled)
  end

  def primary_certificate?
    slug == "primary-certificate"
  end

  def secondary_certificate?
    slug == "secondary-certificate"
  end

  def cs_accelerator?
    slug == "subject-knowledge"
  end

  def i_belong?
    slug == "i-belong"
  end

  def a_level?
    slug == "a-level-certificate"
  end

  def pathways?
    false
  end

  def path
  end

  def public_path
  end

  def enrol_path(opts = {})
  end

  def programme_title
  end

  def bcs_logo
    raise NotImplementedError
  end

  def send_pending_mail?
    false
  end

  def pathways_excluding(pathway)
    pathways.where.not(id: pathway&.id).ordered_by_programme(slug)
  end

  def user_is_eligible?(user)
    true
  end

  def programme_objectives
    programme_activity_groupings.order(:sort_key)
  end

  def programme_objectives_displayed_in_progress_bar
    programme_objectives.select { _1.objective_displayed_in_progress_bar? }
  end

  def programme_objectives_displayed_in_body
    programme_objectives.select { _1.objective_displayed_in_body? }
  end

  def set_user_programme_enrolment_complete_data(enrolment)
    enrolment.certificate_name = enrolment.user.full_name
    enrolment.save!
  end

  def user_qualifies_for_credly_cpd_badge?(user)
    user_enrolled?(user) && user_has_f2f_achievement?(user)
  end

  def auto_enrollable?
    false
  end

  def auto_enrollment_ignored_activity_codes
    []
  end

  def notification_link
    root_path
  end

  def minimum_character_required_community_evidence
    0
  end

  def achievement_type
    raise NotImplementedError
  end

  def enrolment_confirmation_required?
    false
  end

  def show_extra_objectives_on_progress_bar?
    false
  end
end
