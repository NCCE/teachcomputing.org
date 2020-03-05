class Questionnaire < ApplicationRecord
  validates :title, :slug, presence: true
  belongs_to :programme
end
