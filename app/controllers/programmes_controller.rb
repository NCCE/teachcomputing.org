class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :enabled?
  before_action :authenticate_user!
  before_action :find_programme!, only: [:show]

  def show
    if @programme.user_enrolled?(current_user)
      render :show
    else
      redirect_to certification_path
    end
  end

  private

    def enabled?
      redirect_to root_path unless certification_enabled?
    end

    def find_programme!
      @programme = Programme.find_by!(slug: params[:slug])
    end
end
