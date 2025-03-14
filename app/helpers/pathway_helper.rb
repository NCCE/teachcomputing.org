module PathwayHelper
  def should_show_other_pathways?(programme)
    programme.secondary_certificate?
  end
end
