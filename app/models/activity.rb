class Activity < ApplicationRecord
  has_many :achievements, dependent: :restrict_with_exception
  has_many :users, through: :achievements

  def self.created_ncce_account
    Activity.find_or_create_by(slug: 'created-ncce-account') do |activity|
      activity.title = 'Created NCCE account'
      activity.credit = 0
      activity.slug = activity.title.parameterize
    end
  end

  def self.downloaded_diagnostic_tool
    Activity.find_or_create_by(slug: 'downloaded-diagnostic-tool') do |activity|
      activity.title = 'Downloaded diagnostic tool'
      activity.credit = 0
      activity.slug = activity.title.parameterize
    end
  end
end
