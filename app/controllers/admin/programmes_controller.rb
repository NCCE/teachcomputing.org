module Admin
  class ProgrammesController < Admin::ApplicationController
    def index
      @programmes = [
        Programme.cs_accelerator,
        Programme.primary_certificate,
        Programme.secondary_certificate,
        Programme.i_belong,
        Programme.a_level
      ].compact.sort_by(&:title)
    end

    def show
      @programme = Programme.includes(
        programme_activity_groupings: :activities,
        pathways: {pathway_activities: :activity}
      ).find(params[:id])
    end
  end
end
