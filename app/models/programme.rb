require 'sti_preload'

class Programme < ApplicationRecord
  include StiPreload
  include Rails.application.routes.url_helpers

  has_many :programme_activities, dependent: :destroy
  has_many :activities, through: :programme_activities
  has_many :user_programme_enrolments, dependent: :restrict_with_exception
  has_many :users, through: :user_programme_enrolments
  has_many :programme_activity_groupings
  has_one  :assessment, dependent: :destroy
  has_one  :programme_complete_counter, dependent: :destroy
  has_many :achievements, dependent: :nullify
  has_many :questionnaires, dependent: :nullify
  has_many :pathways, dependent: :nullify
  has_many :badges

  validates :title, :description, :slug, presence: true

  scope :enrollable, -> { where(enrollable: true) }

  def self.cs_accelerator
    Programme.find_by(slug: 'cs-accelerator')
  end

  def self.primary_certificate
    Programme.find_by(slug: 'primary-certificate')
  end

  def self.secondary_certificate
    Programme.find_by(slug: 'secondary-certificate')
  end

  def badgeable?
    badges.active.exists?
  end

  def credits_achieved_for_certificate(_user)
    0
  end

  def max_credits_for_certificate
    0
  end

  def enough_activities_for_test?(_user)
    false
  end

  def diagnostic
    activities.find_by(category: 'diagnostic')
  end

  def user_completed?(user)
    enrolment = user.user_programme_enrolments.find_by(programme_id: id)
    return false if enrolment.nil?

    enrolment.in_state?(:complete)
  end

  def user_completed_diagnostic?(user)
    user.achievements.in_state(:complete).where(activity_id: diagnostic.id).exists?
  end

  def user_enrolled?(user)
    return false if user.nil?

    enrolment = user_programme_enrolments.find_by(user_id: user.id)
    enrolment.present? && !enrolment.in_state?(:unenrolled)
  end

  def user_meets_completion_requirement?(user)
    programme_activity_groupings.all? { |group| group.user_complete?(user) }
  end

  def diagnostic_result(*)
    nil
  end

  def primary_certificate?
    slug == 'primary-certificate'
  end

  def secondary_certificate?
    slug == 'secondary-certificate'
  end

  def cs_accelerator?
    slug == 'cs-accelerator'
  end

  def path; end

  def enrol_path(opts = {}); end

  def programme_title; end

  def pathways_excluding(pathway)
    pathways.where.not(id: pathway&.id).ordered_by_programme(slug)
  end
end
