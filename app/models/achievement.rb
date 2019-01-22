class Achievement < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:activity_id]
end
