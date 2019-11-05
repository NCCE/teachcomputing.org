class PrimaryCertificateEnrolmentTransitionJob < ApplicationJob
  queue_as :default

  def perform(user, meta)
  end
end