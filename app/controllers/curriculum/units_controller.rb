module Curriculum
  class UnitsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      @unit = CurriculumClient::Queries::Unit.one(params[:unit_slug]).unit
    end

    protected

      def client
        CurriculumClient::Queries::Unit
      end
  end
end
