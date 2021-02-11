class PathwayActivity < ApplicationRecord
  before_save :update_activity_type
  before_update :update_activity_type

  belongs_to :pathway
  belongs_to :activity, autosave: true, validate: true

  def category
    activity.category
  end
end
