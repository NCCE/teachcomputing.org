class Questionnaire < ApplicationRecord
  validates :title, :slug, presence: true
  belongs_to :programme
  has_many :questionnaire_responses, dependent: :destroy

  def self.cs_accelerator
    find_by(slug: 'cs-accelerator-enrolment-questionnaire')
  end
end
