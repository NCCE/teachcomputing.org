# frozen_string_literal: true

class EnrolmentConfirmationComponent < ViewComponent::Base
  attr_reader :button_text

  delegate :auth_url, to: :helpers

  def initialize(programme:, current_user:, full_width: true, button_text: "Enrol", pathway: nil)
    @current_user = current_user
    @programme = programme
    @full_width = full_width
    @button_text = button_text
    @pathway = pathway
  end

  def button_classes
    classes = ["govuk-button button"]
    classes << "button--full-width" if @full_width
    classes
  end
end
