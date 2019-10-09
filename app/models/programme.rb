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

  def self.diagnostic
    false
  end

  def credits_for_certificate
    if slug == 'cs-accelerator'
      return { online: 40, 'face-to-face': 40 }
    end

    {}
  end

  def user_completed?(user = nil)
    false
  end

  def user_completed_diagnostic?(user)
    false
  end

  def user_enrolled?(user = nil)
    return false if user.nil?

    user.programmes.exists?(id)
  end
end
