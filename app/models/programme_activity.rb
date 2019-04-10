class ProgrammeActivity < ApplicationRecord
  belongs_to :programme
  belongs_to :activity

  validates :programme_id, uniqueness: { scope: [:activity_id] }
end
