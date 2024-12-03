# frozen_string_literal: true

class DashboardCertificateComponent < ViewComponent::Base
  def initialize(certificate:, button_text:, button_color:)
    @certificate = certificate
    @button_text = button_text
    @button_color = button_color
  end

  def tool_tip_text
    if @certificate.achievement_type == :school
      "School achievement"
    else
      "Individual achievement"
    end
  end

  def certificate_classes
    classes = ["dashboard-certificate"]
    classes << if @certificate.achievement_type == :school
      "dashboard-certificate--orange-ribbon"
    else
      "dashboard-certificate--green-ribbon"
    end
    classes
  end

  def tool_tip_classes
    classes = ["tooltip"]
    classes << if @certificate.achievement_type == :school
      "dashboard-certificate__icon--school"
    else
      "dashboard-certificate__icon--individual"
    end
    classes
  end

  def button_classes
    classes = ["govuk-button button govuk-!-margin-bottom-0 govuk-!-margin-top-0"]
    classes << @button_color
    classes
  end
end
