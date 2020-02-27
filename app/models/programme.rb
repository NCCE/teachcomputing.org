class Programme < ApplicationRecord
  has_many :programme_activities, dependent: :destroy
  has_many :activities, through: :programme_activities
  has_many :user_programme_enrolments, dependent: :restrict_with_exception
  has_many :users, through: :user_programme_enrolments
  has_one  :assessment, dependent: :destroy
  has_one  :programme_complete_counter, dependent: :destroy
  has_many :achievements, dependent: :nullify

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

  def credits_achieved_for_certificate(user)
    0
  end

  def max_credits_for_certificate
    0
  end

  def enough_activites_for_test?(user)
    false
  end

  def diagnostic
    activities.find_by(category: 'diagnostic')
  end

  def user_completed?(user)
    enrolment = user.user_programme_enrolments.find_by(programme_id: id)
    return false if enrolment.nil?

    enrolment.current_state == 'complete'
  end

  def user_completed_diagnostic?(user)
    user.achievements.in_state(:complete).where(activity_id: diagnostic.id).exists?
  end

  def user_enrolled?(user)
    return false if user.nil?

    user.programmes.exists?(id)
  end

  def diagnostic_result(*)
    nil
  end
end
