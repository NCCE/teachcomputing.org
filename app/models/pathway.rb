class Pathway < ApplicationRecord
  has_many   :user_programme_enrolments
  has_many   :pathway_activities, dependent: :destroy
end
