module Curriculum
  class UnitsController < ApplicationController
    layout 'full-width'

    def show
      @unit = Queries::Unit.one(params[:unit_slug]).unit
    end
	end
end
