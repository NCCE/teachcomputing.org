class Curriculum::KeyStagesController < ApplicationController
  before_action :enabled?

  def index
  end

  private

  def enabled?
    redirect_to root_path unless curriculum_enabled?
  end
end
