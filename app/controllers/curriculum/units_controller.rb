module Curriculum
  class UnitsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      @unit = CurriculumClient::Queries::Unit.one(params[:unit_slug]).unit
      redirect = CurriculumClient::Queries::Redirect.one(params[:unit_slug], @unit.year_group.key_stage.slug)&.redirect

      return unless redirect.present?

      redirect_to curriculum_key_stage_unit_path(key_stage_slug: @unit.year_group.key_stage.slug, unit_slug: redirect[:to]) if params[:unit_slug] == redirect[:from]
    end

    protected

      def client
        CurriculumClient::Queries::Unit
      end
  end
end
