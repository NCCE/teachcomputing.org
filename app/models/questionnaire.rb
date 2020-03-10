class Questionnaire < ApplicationRecord
  validates :title, :slug, presence: true
  belongs_to :programme
  has_many :questionnaire_responses, dependent: :destroy
end
