class Curriculum::KeyStagesController < ApplicationController
  layout 'full-width'

  before_action :enabled?

  def index
  end

	def show
	end

  private

  def enabled?
    redirect_to root_path unless curriculum_enabled?
  end
end
