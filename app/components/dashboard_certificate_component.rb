# rozen_string_literal: true

class DashboardCertificateComponent < ViewComponent::Base
  def initialize(certificate:)
    @certificate = certificate
  end
end
