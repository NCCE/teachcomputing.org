module Achiever
  class ScheduleCertificateSyncJob < ApplicationJob
    queue_as :achiever

    def perform(enrolment_id)
      # for now we dont want this to run until the initial sync has been done
      # enrolment = UserProgrammeEnrolment.find(enrolment_id)
      # Achiever::User::Enrolment.new(enrolment).sync
    end
  end
end
