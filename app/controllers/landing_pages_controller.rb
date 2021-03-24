class LandingPagesController < ApplicationController
  layout 'full-width'

  def primary_teachers
    @programme = Programme.primary_certificate
  end

  def secondary_teachers
    # TODO: remove the cert assignments
    @cs_accelerator = Programme.cs_accelerator
    @secondary_certificate = Programme.secondary_certificate
    @landing_page = SecondaryLandingPage.new(current_user: current_user)
  end
end
