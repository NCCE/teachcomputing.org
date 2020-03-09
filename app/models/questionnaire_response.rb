class QuestionnaireResponse < ApplicationRecord
  belongs_to :questionnaire
  belongs_to :user
  belongs_to :programme

  validates :questionnaire_id, presence: true
  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: [:programme_id, :questionnaire_id] }
  validates :programme_id, presence: true

  def answer_current_question(answer)
    self.current_question = current_question + 1
    self.answers ||= {}
    self.answers[current_question] = answer
    save
  end
end
