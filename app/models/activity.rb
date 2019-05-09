class Activity < ApplicationRecord
  has_many :achievements, dependent: :restrict_with_exception
  has_many :users, through: :achievements
  has_many :imports, dependent: :nullify
  has_many :programme_activities, dependent: :destroy
  has_many :programmes, through: :programme_activities

  validates :title, :slug, :category, presence: true
  validates :category, inclusion: { in: %w[action cpd] }
  validates :provider, inclusion: { in: %w[future-learn stem-learning system] }

  scope :available_for, ->(user) { where('id NOT IN (SELECT activity_id FROM achievements WHERE user_id = ?)', user.id) }
  scope :cpd, -> { where(category: 'cpd') }
  scope :future_learn, -> { where(provider: 'future-learn') }
  scope :non_action, -> { where.not(category: 'action') }
  scope :self_certifiable, -> { where(self_certifiable: true) }
  scope :system, -> { where(provider: 'system') }
  scope :user_removable, -> { self_certifiable.non_action }

  def user_removable?
    self_certifiable && category != 'action'
  end

  def self.diagnostic_tool
    Activity.find_or_create_by(slug: 'diagnostic-tool') do |activity|
      activity.title = 'Taken diagnostic tool'
      activity.credit = 10
      activity.slug = 'diagnostic-tool'
      activity.category = 'action'
      activity.self_certifiable = true
      activity.provider = 'system'
    end
  end

  def self.registered_with_the_national_centre
    Activity.find_or_create_by(slug: 'registered-with-the-national-centre') do |activity|
      activity.title = 'Registered with the National Centre'
      activity.credit = 5
      activity.slug = activity.title.parameterize
      activity.category = 'action'
      activity.self_certifiable = false
      activity.provider = 'system'
    end
  end
end
