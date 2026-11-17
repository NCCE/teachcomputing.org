module Curriculum
  class KeyStagesController < ApplicationController
    layout "full-width"

    def show
      @key_stage = CurriculumClient::Queries::KeyStage.one(params[:key_stage_slug]).key_stage
    end
  end
end
