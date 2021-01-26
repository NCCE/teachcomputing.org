module Achiever
  class ScheduleCertificateSyncJob < ApplicationJob
    queue_as :achiever

    def perform(enrolment_id)
      enrolment = UserProgrammeEnrolment.find(enrolment_id)
      Achiever::User::Enrolment.new(enrolment).sync if FeatureFlagService.new.flags[:certification_sync_enabled]
    end
  end
end
