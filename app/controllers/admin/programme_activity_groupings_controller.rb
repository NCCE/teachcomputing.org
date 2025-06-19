module Admin
  class ProgrammeActivityGroupingsController < Admin::ApplicationController
    def find_resource(param)
      ProgrammeActivityGrouping.find_by!(id: param)
    end

    def resource_params
      params.require(resource_class.model_name.param_key).permit(
        dashboard.permitted_attributes(action_name),
        web_copy: {}
      )
    end
  end
end
