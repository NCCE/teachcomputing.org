module Curriculum
  class LessonsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      @lesson = CurriculumClient::Queries::Lesson.one(params[:lesson_slug], params[:unit_slug])&.lesson
      raise ActiveRecord::RecordNotFound if @lesson.blank?

      @unit = @lesson.unit

      redirect = CurriculumClient::Queries::Redirect.one(params[:lesson_slug], params[:unit_slug])&.redirect
      redirect_to curriculum_key_stage_unit_lesson_path(key_stage_slug: params[:key_stage_slug], unit_slug: redirect[:to_context], lesson_slug: redirect[:to]) if redirect.present?
    end

    protected

      def client
        CurriculumClient::Queries::Lesson
      end
  end
end
