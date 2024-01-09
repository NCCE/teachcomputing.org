module Curriculum
  class KeyStagesController < ApplicationController
    layout "full-width"

    def index
      @key_stages = CurriculumClient::Queries::KeyStage.all.key_stages
    end

    def show
      @key_stage = CurriculumClient::Queries::KeyStage.one(params[:key_stage_slug]).key_stage
    end
  end
end
