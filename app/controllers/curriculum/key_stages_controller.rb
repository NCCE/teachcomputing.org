module Curriculum
  class KeyStagesController < ApplicationController
    layout 'full-width'

    before_action :enabled?

    def index
      @key_stages = Queries::KeyStage.all.key_stages
    end

    def show
    end

    private

    def enabled?
      redirect_to root_path unless curriculum_enabled?
    end
  end
end
