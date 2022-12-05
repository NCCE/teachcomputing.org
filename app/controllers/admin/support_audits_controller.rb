module Admin
  class SupportAuditsController < Admin::ApplicationController
    def after_resource_updated_path(requested_resource)
      return admin_user_path(id: requested_resource.auditable_id) if User.exists? requested_resource.auditable_id

      admin_user_path(id: requested_resource.user_id)
    end

    def authorized_action?(resource, action_name)
      return false if resource.instance_of?(SupportAudit) && action_name == :edit

      true
    end
  end
end
