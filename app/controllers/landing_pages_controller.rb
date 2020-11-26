class LandingPagesController < ApplicationController
  layout 'full-width'

  def primary_teachers
    @programme = Programme.primary_certificate
  end

  def secondary_teachers
    @cs_accelerator = Programme.cs_accelerator
    @secondary_certificate = Programme.secondary_certificate
  end
end
