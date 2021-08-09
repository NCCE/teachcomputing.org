class FeedbackComment < ApplicationRecord
  validates :area, :comment, presence: true
end
