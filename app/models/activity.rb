class Activity < ApplicationRecord
  FACE_TO_FACE_CATEGORY = 'face-to-face'
  ONLINE_CATEGORY = 'online'
  ACTION_CATEGORY = 'action'
  COMMUNITY_CATEGORY = 'community'
  ASSESSMENT_CATEGORY = 'assessment'

  has_many :achievements, dependent: :restrict_with_exception
  has_many :users, through: :achievements
  has_many :programme_activities, dependent: :destroy
  has_many :programmes, through: :programme_activities
  has_one  :assessment

  validates :title, :slug, :category, presence: true
  validates :category, inclusion: { in: [ACTION_CATEGORY, ONLINE_CATEGORY, FACE_TO_FACE_CATEGORY, ASSESSMENT_CATEGORY, COMMUNITY_CATEGORY] }
  validates :provider, inclusion: { in: %w[future-learn stem-learning system classmarker cas barefoot code-club] }

  scope :available_for, ->(user) { where('id NOT IN (SELECT activity_id FROM achievements WHERE user_id = ?)', user.id) }
  scope :online, -> { where(category: ONLINE_CATEGORY) }
  scope :face_to_face, -> { where(category: FACE_TO_FACE_CATEGORY) }
  scope :future_learn, -> { where(provider: 'future-learn') }
  scope :stem_learning, -> { where(provider: 'stem-learning') }
  scope :community, -> { where(category: COMMUNITY_CATEGORY) }
  scope :non_action, -> { where.not(category: ACTION_CATEGORY) }
  scope :self_certifiable, -> { where(self_certifiable: true) }
  scope :system, -> { where(provider: 'system') }
  scope :user_removable, -> { self_certifiable.non_action }

  def user_removable?
    self_certifiable && category != ACTION_CATEGORY
  end

  def self.diagnostic_tool
    Activity.find_or_create_by(slug: 'diagnostic-tool') do |activity|
      activity.title = 'Taken diagnostic tool'
      activity.credit = 10
      activity.slug = 'diagnostic-tool'
      activity.category = ACTION_CATEGORY
      activity.self_certifiable = true
      activity.provider = 'system'
    end
  end

  def self.registered_with_the_national_centre
    Activity.find_or_create_by(slug: 'registered-with-the-national-centre') do |activity|
      activity.title = 'Registered with the National Centre'
      activity.credit = 5
      activity.slug = activity.title.parameterize
      activity.category = ACTION_CATEGORY
      activity.self_certifiable = false
      activity.provider = 'system'
    end
  end
end
