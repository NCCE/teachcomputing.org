module Curriculum
  class LessonsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      @lesson = CurriculumClient::Queries::Lesson.one(params[:lesson_slug], params[:unit_slug]).lesson

      # TODO: Add redirect handling...almost identical to the unit_controller but passing through the unit_slug as well as the lesson slug for uniqueness

      raise ActiveRecord::RecordNotFound if @lesson.nil?

      @unit = @lesson.unit
    end

    protected

      def client
        CurriculumClient::Queries::Lesson
      end
  end
end
