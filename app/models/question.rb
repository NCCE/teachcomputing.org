class Question < ApplicationRecord
  has_many :answers
  has_many :assessment_responses, through: :answers
  belongs_to :category

  validates :text, presence: true
  validates :correct, presence: true
  validates :difficulty, inclusion: { in: %w[low medium hard] }

  scope :with_low_difficulty, -> { where(difficulty: 'low') }
  scope :with_medium_difficulty, -> { where(difficulty: 'medium') }
  scope :with_hard_difficulty, -> { where(difficulty: 'hard') }
end
