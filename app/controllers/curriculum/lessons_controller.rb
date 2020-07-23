module Curriculum
  class LessonsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def client
      CurriculumClient::Queries::Lesson
    end

    def show
      @lesson = CurriculumClient::Queries::Lesson.one(params[:lesson_slug]).lesson
      @has_rated = rating(@lesson.id)
    end
  end
end
