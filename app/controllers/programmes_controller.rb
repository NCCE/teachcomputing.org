class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :is_enabled?
  before_action :authenticate_user!
  before_action :find_programme!, only: [:show]

  def show
    unless @programme.is_user_enrolled?(current_user)
      redirect_to certification_path
    else
      render :show
    end
  end

  private
    def is_enabled?
      unless certification_enabled?
        redirect_to root_path
      end
    end

    def find_programme!
      @programme = Programme.find_by!(slug: params[:slug])
    end
end
