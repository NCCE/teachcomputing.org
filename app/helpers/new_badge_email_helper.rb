module NewBadgeEmailHelper
  def programme_name(programme)
    if programme&.cs_accelerator?
      "our Subject knowledge certificate"
    elsif programme&.secondary_certificate?
      "Teach secondary computing"
    elsif programme&.primary_certificate?
      "Teach primary computing"
    end
  end
end
