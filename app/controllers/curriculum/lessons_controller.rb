module Curriculum
  class LessonsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      @lesson = CurriculumClient::Queries::Lesson.one(params[:lesson_slug], params[:unit_slug]).lesson

      raise ActiveRecord::RecordNotFound if @lesson.nil?

      @unit = @lesson.unit

      redirect = CurriculumClient::Queries::Redirect.one(params[:lesson_slug], @unit.year_group.key_stage.slug)&.redirect

      return unless redirect.present?

      redirect_to curriculum_key_stage_unit_lesson_path(key_stage_slug: @unit.year_group.key_stage.slug, unit_slug: @unit.year_group.key_stage.slug, lesson_slug: @lesson.slug) if params[:lesson_slug] == redirect[:from]
    end

    protected

      def client
        CurriculumClient::Queries::Lesson
      end
  end
end
