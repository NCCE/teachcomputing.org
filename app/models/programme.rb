class Programme < ApplicationRecord
  has_many :programme_activities, dependent: :destroy
  has_many :activities, through: :programme_activities
  has_many :user_programme_enrolments, dependent: :restrict_with_exception
  has_many :users, through: :user_programme_enrolments
  has_one  :assessment, dependent: :destroy

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

  def credits_for_certificate
    return { online: 40, 'face-to-face': 40 } if slug == 'cs-accelerator'

    {}
  end

  def diagnostic
    activities.find_by(category: 'diagnostic')
  end

  def user_completed?(_user = nil)
    false
  end

  def user_completed_diagnostic?(user)
    user.achievements.in_state(:complete).where(activity_id: diagnostic.id).exists?
  end

  def user_enrolled?(user)
    return false if user.nil?
    
    user.programmes.exists?(id)
  end

  def course_recommendations(*)
    []
  end
end
