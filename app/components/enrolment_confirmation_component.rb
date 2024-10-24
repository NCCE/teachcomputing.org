# frozen_string_literal: true

class EnrolmentConfirmationComponent < ViewComponent::Base
  delegate :auth_url, to: :helpers

  def initialize(programme:, current_user:, enrol_text: nil)
    @current_user = current_user
    @programme = programme
    @enrol_text = enrol_text
  end
end
