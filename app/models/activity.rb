class Activity < ApplicationRecord
  has_many :achievements, dependent: :restrict_with_exception
  has_many :users, through: :achievements

  validates :title, :slug, :category, presence: true
  validates :category, inclusion: { in: %w[action cpd] }

  scope :available_for, ->(user) { where('id NOT IN (SELECT activity_id FROM achievements WHERE user_id = ?)', user.id) }
  scope :cpd, -> { where(category: 'cpd') }

  def self.downloaded_diagnostic_tool
    Activity.find_or_create_by(slug: 'downloaded-diagnostic-tool') do |activity|
      activity.title = 'Downloaded diagnostic tool'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'action'
    end
  end
end
