module Curriculum
  class KeyStagesController < ApplicationController
    layout "full-width"

    def index
      file_client = CurriculumClient::Queries::FileUpload
      @journey_progress_pdf = file_client.one("journey-progress-pdf").file_upload
      @journey_progress_icon = file_client.one("journey-progress-icon").file_upload
      @primary_journey_progress_pdf = file_client.one("primary-journey-progress-pdf").file_upload
      @secondary_journey_progress_pdf = file_client.one("secondary-journey-progress-pdf").file_upload

      @key_stages = CurriculumClient::Queries::KeyStage.all.key_stages
    end

    def show
      @key_stage = CurriculumClient::Queries::KeyStage.one(params[:key_stage_slug]).key_stage
    end
  end
end
