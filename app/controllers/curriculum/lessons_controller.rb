module Curriculum
  class LessonsController < ApplicationController
    include Curriculum::Rateable

    layout "full-width"

    def show
      redirect = CurriculumClient::Queries::Redirect.one(params[:lesson_slug], params[:unit_slug])&.redirect

      if redirect.present?
        redirect_to curriculum_key_stage_unit_lesson_path(
          key_stage_slug: redirect[:to_context].first,
          unit_slug: redirect[:to_context].last,
          lesson_slug: redirect[:to]
        ) and return
      end

      @lesson = CurriculumClient::Queries::Lesson.one(params[:lesson_slug], params[:unit_slug])&.lesson
      @unit = @lesson.unit
    end

    protected

    def client
      CurriculumClient::Queries::Lesson
    end
  end
end
