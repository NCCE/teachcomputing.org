class Assessment < ApplicationRecord
  belongs_to :programme
  belongs_to :activity
  has_many   :assessment_attempts, dependent: :destroy
end
