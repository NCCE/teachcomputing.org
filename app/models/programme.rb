class Programme < ApplicationRecord
  has_many :programme_activities, dependent: :destroy
  has_many :activities, through: :programme_activities
  has_many :user_programme_enrolments, dependent: :restrict_with_exception
  has_many :users, through: :user_programme_enrolments
  has_one  :assessment, dependent: :destroy

  validates :title, :description, :slug, presence: true

  scope :enrollable, -> { where(enrollable: true) }

  def user_enrolled?(user = nil)
    return false if user.nil?

    user.programmes.exists?(id)
  end

  def self.cs_accelerator
    Programme.find_by(slug: 'cs-accelerator')
  end

  def self.primary_certificate
    Programme.find_by(slug: 'primary-certificate')
  end

  def self.secondary_certificate
    Programme.find_by(slug: 'secondary-certificate')
  end

  def user_completed?(user = nil)
    if slug == 'cs-accelerator'
      return user.achievements
                 .for_programme(self)
                 .in_state('complete')
                 .joins(:activity)
                 .where(activities: { category: 'assessment' }).any?
    end

    false
  end
end
