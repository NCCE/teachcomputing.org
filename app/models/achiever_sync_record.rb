class AchieverSyncRecord < ApplicationRecord
  belongs_to :user_programme_enrolment

  validates :user_programme_enrolment_id, uniqueness: {scope: [:state]}
  validates :state, inclusion: {in: %w[enrolled pending complete unenrolled]}
end
