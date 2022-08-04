module Curriculum
  class LessonsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      @lesson = CurriculumClient::Queries::Lesson.one(params[:lesson_slug], params[:unit_slug]).lesson

      raise ActiveRecord::RecordNotFound if @lesson.nil?

      @unit = @lesson.unit
    end

    protected

      def client
        CurriculumClient::Queries::Lesson
      end
  end
end
