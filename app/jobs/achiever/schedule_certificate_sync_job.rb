module Achiever
  class ScheduleCertificateSyncJob < ApplicationJob
    queue_as :achiever

    def perform(enrolment_id)
      enrolment = UserProgrammeEnrolment.find(enrolment_id)
      Achiever::User::Enrolment.new(enrolment).sync
    end
  end
end
