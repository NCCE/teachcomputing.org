class FeedbackComment < ApplicationRecord
  validates :area, :comment, presence: true

  belongs_to :user
end
