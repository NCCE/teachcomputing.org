class Assessment < ApplicationRecord
  belongs_to :programme
  belongs_to :activity
  has_many   :assessment_attempts, dependent: :destroy

  validates :link, presence: true
end
