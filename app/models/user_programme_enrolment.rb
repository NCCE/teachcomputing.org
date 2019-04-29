class UserProgrammeEnrolment < ApplicationRecord
  belongs_to :user
  belongs_to :programme
end
