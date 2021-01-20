class PathwayActivity < ApplicationRecord
  before_save :update_activity_type

  belongs_to :pathway
  belongs_to :activity

  enum activity_type: %i[face-to-face online supplemental]

  def update_activity_type
    self.activity_type = activity.category
  end
end
