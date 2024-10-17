# frozen_string_literal: true

class DashboardCertificateComponentPreview < ViewComponent::Preview
  def default
    render DashboardCertificateComponent.new(
      certificate: Programme.primary_certificate,
      button_text: "Click here",
      button_color: "ncce-button"
    )
  end

  def i_belong
    render DashboardCertificateComponent.new(
      certificate: Programme.i_belong,
      button_text: "Click here",
      button_color: "ncce-button"
    )
  end
end
