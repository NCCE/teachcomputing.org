module Curriculum
  class UnitsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      @unit = CurriculumClient::Queries::Unit.one(params[:unit_slug]).unit
      redirects = CurriculumClient::Queries::Redirects.all.redirects

      redirects.each do |redirect|
        if (params[:unit_slug] == redirect[:from])
          redirect_to curriculum_key_stage_unit_path(
            key_stage_slug: @unit.year_group.key_stage.slug, unit_slug: redirect[:to]
          )
        end
      end
    end

    protected

      def client
        CurriculumClient::Queries::Unit
      end
  end
end
