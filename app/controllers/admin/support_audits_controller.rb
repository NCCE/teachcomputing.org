module Admin
  class SupportAuditsController < Admin::ApplicationController
    def default_sorting_attribute
      :created_at
    end

    def default_sorting_direction
      :desc
    end

    def after_resource_updated_path(_requested_resource)
      admin_users_path
    end

    def authorized_action?(resource, action_name)
      return false if resource.instance_of?(SupportAudit) && action_name == :edit

      true
    end
  end
end
