class PrimaryCertificateEnrolmentTransitionJob < ApplicationJob
  queue_as :default

  def perform(user, meta)
    true
    # place holder job
  end
end
