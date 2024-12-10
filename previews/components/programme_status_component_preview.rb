class ProgrammeStatusComponentPreview < ViewComponent::Preview
  class UPEMock
    def initialize(status)
      @status = status
    end

    def in_state?(status)
      @status == status
    end

    def programme = Programme.primary_certificate
  end

  def pending
    user_programme_enrolment = UPEMock.new(:pending)
    render(
      ProgrammeStatusComponent.new(user_programme_enrolment:)
    )
  end

  def complete
    user_programme_enrolment = UPEMock.new(:complete)
    render(
      ProgrammeStatusComponent.new(user_programme_enrolment:)
    )
  end
end
