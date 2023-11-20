class Activity < ApplicationRecord
  ACTION_CATEGORY = 'action'.freeze
  ASSESSMENT_CATEGORY = 'assessment'.freeze
  COMMUNITY_CATEGORY = 'community'.freeze
  DIAGNOSTIC_CATEGORY = 'diagnostic'.freeze
  FACE_TO_FACE_CATEGORY = 'face-to-face'.freeze # includes live remote courses
  ONLINE_CATEGORY = 'online'.freeze # self-paced

  has_many :achievements, dependent: :restrict_with_exception
  has_many :users, through: :achievements
  has_many :programme_activities, dependent: :destroy
  has_many :programmes, through: :programme_activities
  has_many :pathway_activities, dependent: :destroy
  has_one  :assessment

  validates :title, :slug, :category, presence: true
  validates :category, inclusion: { in: [
    ACTION_CATEGORY, ASSESSMENT_CATEGORY, COMMUNITY_CATEGORY,
    DIAGNOSTIC_CATEGORY, FACE_TO_FACE_CATEGORY, ONLINE_CATEGORY
  ] }
  validates :provider, inclusion: {
    in: %w[barefoot cas classmarker future-learn isaac ncce raspberrypi stem-learning system]
  }
  validates :future_learn_course_uuid, uniqueness: true, unless: proc { |a| a.future_learn_course_uuid.blank? }
  validates :stem_activity_code, uniqueness: true, unless: proc { |a| a.stem_activity_code.blank? }
  validates :stem_course_template_no, uniqueness: true, unless: proc { |a| a.stem_course_template_no.blank? }

  scope :available_for, lambda { |user|
    where('id NOT IN (SELECT activity_id FROM achievements WHERE user_id = ?)', user.id)
  }
  scope :courses, -> { where(category: [FACE_TO_FACE_CATEGORY, ONLINE_CATEGORY]) }
  scope :online, -> { where(category: ONLINE_CATEGORY) }
  scope :face_to_face, -> { where(category: FACE_TO_FACE_CATEGORY) }
  scope :future_learn, -> { where(provider: 'future-learn') }
  scope :stem_learning, -> { where(provider: 'stem-learning') }
  scope :my_learning, -> { stem_learning.online }
  scope :community, -> { where(category: COMMUNITY_CATEGORY) }
  scope :non_action, -> { where.not(category: ACTION_CATEGORY) }
  scope :self_certifiable, -> { where(self_certifiable: true) }
  scope :system, -> { where(provider: 'system') }
  scope :user_removable, -> { self_certifiable.non_action }

  store_accessor :public_copy, %i[title_url description evidence_brief evidence_bullets], prefix: true

  def self.cs_accelerator_diagnostic_tool
    Activity.find_or_create_by(slug: 'cs-accelerator-diagnostic-tool') do |activity|
      activity.title = 'Taken diagnostic tool'
      activity.credit = 10
      activity.slug = 'cs-accelerator-diagnostic-tool'
      activity.category = DIAGNOSTIC_CATEGORY
      activity.self_certifiable = false
      activity.provider = 'system'
    end
  end

  def online?
    category == ONLINE_CATEGORY
  end

  def active_course?
    self.stem_activity_code.present? && self.retired == false
  end
end
