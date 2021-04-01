class LandingPagesController < ApplicationController
  layout 'full-width'

  def primary_teachers
    # @programme = Programme.primary_certificate
    @landing_page = PrimaryLandingPage.new(current_user: current_user)
    render :show
  end

  def secondary_teachers
    @landing_page = SecondaryLandingPage.new(current_user: current_user)
    render :show
  end
end
