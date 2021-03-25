module Achiever
  class ScheduleCertificateSyncJob < ApplicationJob
    retry_on Faraday::TimeoutError, Faraday::ConnectionFailed, Faraday::SSLError, wait: 1.minute
    queue_as :achiever

    def perform(enrolment_id)
      enrolment = UserProgrammeEnrolment.find(enrolment_id)

      return if AchieverSyncRecord.find_by(user_programme_enrolment_id: enrolment.id, state: enrolment.current_state)

      Achiever::User::Enrolment.new(enrolment).sync
      AchieverSyncRecord.create(user_programme_enrolment_id: enrolment.id, state: enrolment.current_state)
    end
  end
end
