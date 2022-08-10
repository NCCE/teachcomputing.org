module Curriculum
  class UnitsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      @unit = CurriculumClient::Queries::Unit.one(params[:unit_slug])&.unit
      raise ActiveRecord::RecordNotFound if @unit.blank?

      redirect = CurriculumClient::Queries::Redirect.one(params[:unit_slug], params[:key_stage_slug])&.redirect
      redirect_to curriculum_key_stage_unit_path(key_stage_slug: redirect[:to_context], unit_slug: redirect[:to]) if redirect.present?
    end

    protected

      def client
        CurriculumClient::Queries::Unit
      end
  end
end
