module Admin
  class AssessmentAttemptsController < Admin::ApplicationController
    def after_resource_updated_path(requested_resource)
      edit_admin_support_audit_path(id: requested_resource.support_audits.last.id)
    end
  end
end
