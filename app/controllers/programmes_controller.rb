class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!

  def show
    @programme = Programme.find_by(slug: params[:slug])
    if @programme.nil?
      render template: 'pages/exception', status: 404
    elsif !current_user.programmes.exists?(slug: params[:slug])
      redirect_to certification_path
    else
      render :show
    end
  end
end
