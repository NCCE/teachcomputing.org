class LandingPagesController < ApplicationController
  layout 'full-width'
  before_action :find_programme

  def primary_teachers
    render "landing_pages/primary-teachers"
  end

  def secondary_teachers
    render "landing_pages/secondary-teachers"
  end

  private

    def find_programme
      @programme = Programme.enrollable.find_by!(slug: params[:slug])
    end
end
