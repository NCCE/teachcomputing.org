class QuestionCategory < ApplicationRecord
  has_many :questions

  validates :title, presence: true
  validates :slug, presence: true
end
