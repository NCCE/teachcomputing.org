module Admin
  class ReportsController < Admin::ApplicationController
    def index
      @programmes = [Programme.primary_certificate, Programme.secondary_certificate, Programme.i_belong]
    end

    def by_programme
      @programme = Programme.find(params[:programme_id])
    end

    def report_results
      @programme = Programme.find(params[:programme_id])
      if params[:query]
        groups = if query_params[:programme_activity_groupings]
          query_params[:programme_activity_groupings].compact.map { ProgrammeActivityGrouping.find(_1) }
        else
          []
        end
        @users = Programmes::ProgressQuery.new(
          @programme,
          query_params[:state].to_sym,
          query_params[:enrolled] == "1",
          groups
        ).call
      else
        redirect_to by_programme_admin_reports_path(programme_id: @programme.id)
      end
    end

    private

    def query_params
      params.require(:query).permit(:enrolled, :state, programme_activity_groupings: [])
    end
  end
end
