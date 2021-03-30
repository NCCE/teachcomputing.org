class LandingPagesController < ApplicationController
  layout 'full-width'

  def primary_teachers
    @programme = Programme.primary_certificate
  end

  def secondary_teachers
    @landing_page = SecondaryLandingPage.new(current_user: current_user)
  end
end
