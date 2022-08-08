module Curriculum
  class UnitsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      @unit = CurriculumClient::Queries::Unit.one(params[:unit_slug])&.unit

      if @unit.nil?
        redirect = CurriculumClient::Queries::Redirect.one(params[:unit_slug], param[:unit_slug])&.redirect
        if redirect.present? && params[:unit_slug] == redirect[:from]
          redirect_to curriculum_key_stage_unit_path(key_stage_slug: params[:unit_slug], unit_slug: redirect[:to]) if params[:unit_slug] == redirect[:from]
          return
        end
        raise ActiveRecord::RecordNotFound
      end
    end

    protected

      def client
        CurriculumClient::Queries::Unit
      end
  end
end
