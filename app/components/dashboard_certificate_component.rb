# frozen_string_literal: true

class DashboardCertificateComponent < ViewComponent::Base
  PROGRAMMES = {
    Programmes::PrimaryCertificate => {
      title: "Teach primary computing",
      programme_type: Programme.primary_certificate
    },
    Programmes::SecondaryCertificate => {
      title: "Teach secondary computing",
      programme_type: Programme.secondary_certificate
    },
    Programmes::IBelong => {
      title: "I Belong",
      programme_type: Programme.i_belong
    },
    Programmes::CSAccelerator => {
      title: "Key Stage 3 and GCSE subject knowledge",
      programme_type: Programme.cs_accelerator
    },
    Programmes::ALevel => {
      title: "A level subject knowledge",
      programme_type: Programme.a_level
    }
  }

  def initialize(certificate:, button_text:)
    @certificate = certificate
    @button_text = button_text
  end

  def programme
    PROGRAMMES[@certificate.class]
  end

  def title
    programme[:title]
  end

  def programme_type
    programme[:programme_type]
  end

  def tool_tip_text
    if programme_type.school_achievement?
      "School achievement"
    else
      "Individual achievement"
    end
  end
end
