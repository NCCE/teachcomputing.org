class PathwayActivity < ApplicationRecord
  belongs_to :pathway
  belongs_to :activity, autosave: true, validate: true

  def category
    activity.category
  end
end
