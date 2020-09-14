module Curriculum
  class LessonsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      @unit = CurriculumClient::Queries::Unit.one(params[:unit_slug]).unit
      @lesson = @unit.lessons.select { |lesson| lesson.slug == params[:lesson_slug] }[0]
      raise ActiveRecord::RecordNotFound if @lesson.nil?
    end

    protected

      def client
        CurriculumClient::Queries::Lesson
      end
  end
end
