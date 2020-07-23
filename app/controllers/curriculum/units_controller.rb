module Curriculum
  class UnitsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def client
      CurriculumClient::Queries::Unit
    end

    def show
      @unit = CurriculumClient::Queries::Unit.one(params[:unit_slug]).unit
      @has_rated = rating(@unit.id)
    end
  end
end
