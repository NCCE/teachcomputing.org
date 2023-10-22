class ProgrammesController < ApplicationController
  layout 'full-width'

  before_action :authenticate_user!
  before_action :set_programme

  def show
  end

  private

  def set_programme
    @programme = Programme.find_by!(slug: params[:slug])
  end
end
