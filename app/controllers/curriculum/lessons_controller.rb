module Curriculum
  class LessonsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      @lesson = CurriculumClient::Queries::Lesson.one(params[:lesson_slug], params[:unit_slug]).lesson

      raise ActiveRecord::RecordNotFound if @lesson.nil?

      @unit = @lesson.unit
      
      # TODO: Add redirect handling...almost identical to the unit_controller but passing through the unit_slug as well as the lesson slug for uniqueness

      redirect = CurriculumClient::Queries::Redirect.one(params[:lesson_slug], params[:unit_slug], @lesson.slug)&.redirect

      return unless redirect.present?

      redirect_to curriculum_key_stage_unit_path(lesson_slug: @lesson.slug, unit_slug: redirect[:to]) if params[:unit_slug] == redirect[:from]

    end

    protected

      def client
        CurriculumClient::Queries::Lesson
      end
  end
end
