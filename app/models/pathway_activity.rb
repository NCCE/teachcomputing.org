class PathwayActivity < ApplicationRecord
  belongs_to :pathway
  belongs_to :activity, autosave: true, validate: true

  delegate :title, :stem_activity_code, :slug, :category, :online?, to: :activity
end
