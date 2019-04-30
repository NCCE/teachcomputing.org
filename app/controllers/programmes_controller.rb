class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!

  def show
    @programme = Programme.find_by(slug: params[:slug])
    unless current_user.programmes.exists?(slug: params[:slug])
      redirect_to certification_path
    else
      render :show
    end
  end
end
