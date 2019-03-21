class Answer < ApplicationRecord
  belongs_to :question

  validates :text, presence: true
  validates :label, presence: true
  validates :correct, presence: true
end
