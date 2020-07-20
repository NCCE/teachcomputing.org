module Curriculum
  class LessonsController < ApplicationController
    layout 'full-width'

    def show
      @lesson = Queries::Lesson.one(params[:lesson_slug]).lesson
    end
	end
end
