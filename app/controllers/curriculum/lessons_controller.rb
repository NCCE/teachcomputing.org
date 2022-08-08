module Curriculum
  class LessonsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      begin
        @lesson = CurriculumClient::Queries::Lesson.one(params[:lesson_slug], params[:unit_slug])&.lesson
      rescue ActiveRecord::RecordNotFound
      end

      if @lesson.nil?
        redirect = CurriculumClient::Queries::Redirect.one(params[:lesson_slug], params[:unit_slug])&.redirect
        if redirect.present? && params[:lesson_slug] == redirect[:from]
          redirect_to curriculum_key_stage_unit_lesson_path(key_stage_slug: params[:key_stage_slug], unit_slug: params[:unit_slug], lesson_slug: redirect[:to])
          return
        end
        raise ActiveRecord::RecordNotFound
      end
      @unit = @lesson.unit
    end

    protected

      def client
        CurriculumClient::Queries::Lesson
      end
  end
end
