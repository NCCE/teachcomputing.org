class ProgrammeActivityGrouping < ApplicationRecord
  has_many :programme_activities
  belongs_to :programme
end
