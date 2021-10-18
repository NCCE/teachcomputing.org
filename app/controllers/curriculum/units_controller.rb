module Curriculum
  class UnitsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      @unit = CurriculumClient::Queries::Unit.one(params[:unit_slug]).unit
      @unit_downloads = [@unit.unit_guide] + @unit.learning_graphs + @unit.rubrics + @unit.summative_assessments + @unit.summative_answers
    end

    protected

      def client
        CurriculumClient::Queries::Unit
      end
  end
end
