module Admin
  class UsersController < Admin::ApplicationController
    def perform_sync
      user_id = params[:user_id]
      Support::UserUtilities.sync(user_id)

      redirect_back(
        fallback_location: admin_users_path(user_id: user_id),
        flash: { notice: I18n.t('admin.users.actions.sync.complete') }
      )
    end

    def after_resource_updated_path(requested_resource)
      edit_admin_support_audit_path(id: requested_resource.support_audits.last.id)
    end

    def authorized_action?(resource, action_name)
      return false if resource.instance_of?(SupportAudit) && action_name == :edit

      true
    end
  end
end
