class Import < ApplicationRecord
  validates :provider, :triggered_by, presence: true
  validates :provider, inclusion: { in: %w[future-learn] }

  scope :by_completed_at, -> { order(completed_at: 'desc') }
end
