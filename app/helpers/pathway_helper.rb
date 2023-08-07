module PathwayHelper
  def should_show_other_pathways?(programme)
    programme.secondary_certificate?
  end

  def should_show_funding?(programme)
    programme.primary_certificate?
  end
end
