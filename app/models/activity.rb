class Activity < ApplicationRecord
  has_many :achievements, dependent: :restrict_with_exception
  has_many :users, through: :achievements
  has_many :imports, dependent: :nullify
  has_many :programme_activities, dependent: :destroy
  has_many :programmes, through: :programme_activities

  validates :title, :slug, :category, presence: true
  validates :category, inclusion: { in: %w[action cpd] }
  validates :provider, inclusion: { in: %w[future-learn stem-learning] }

  scope :available_for, ->(user) { where('id NOT IN (SELECT activity_id FROM achievements WHERE user_id = ?)', user.id) }
  scope :cpd, -> { where(category: 'cpd') }
  scope :future_learn, -> { where(provider: 'future-learn') }
  scope :self_certifiable, -> { where(self_certifiable: true) }
  scope :non_action, -> { where.not(category: 'action') }
  scope :user_removable, -> { self_certifiable.non_action }

  def user_removable?
    self_certifiable && category != 'action'
  end

  def self.downloaded_diagnostic_tool
    Activity.find_or_create_by(slug: 'downloaded-diagnostic-tool') do |activity|
      activity.title = 'Downloaded diagnostic tool'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'action'
      activity.self_certifiable = true
      activity.provider = 'stem-learning'
    end
  end
end
