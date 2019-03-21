class Assessment < ApplicationRecord
  has_many :questions
  has_many :assessment_responses

  accepts_nested_attributes_for :assessment_responses
end
