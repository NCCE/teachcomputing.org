module Curriculum
  class KeyStagesController < ApplicationController
    layout 'full-width'

    before_action :enabled?

    def index
      @key_stages = Curriculum::Queries::KeyStage.all.key_stages
    end

    def show
      @key_stage = Curriculum::Queries::KeyStage.one(params[:key_stage_slug]).key_stage
    end

    private

      def enabled?
        redirect_to root_path unless curriculum_enabled?
      end
  end
end
