module Admin
  class UsersController < Admin::ApplicationController
    def perform_sync
      user_id = params[:user_id]
      Support::UserUtilities.sync(user_id)

      redirect_back(
        fallback_location: admin_users_path(user_id:),
        flash: {notice: I18n.t("admin.users.actions.sync.complete")}
      )
    end

    def perform_reset_tests
      admin_user = User.find_by_email(ENV.fetch("DEFAULT_ADMIN_EMAIL"))
      result = Support::UserUtilities.reset_tests(params[:user_id])

      if result.empty?
        redirect_back(
          fallback_location: admin_users_path(params[:user_id]),
          flash: {notice: I18n.t("admin.users.actions.reset.empty")}
        )
      else
        last_audit = SupportAudit.where(user_id: admin_user.id).last
        redirect_to edit_admin_support_audit_path(id: last_audit.id)
      end
    end

    def generate_assessment_attempt
      @user = User.find(params[:user_id])
    end

    def process_assessment_attempt
      @user = User.find(params[:user_id])
      assessment = Assessment.find(params[:assessment_id])
      if assessment.activity
        achievement = assessment.activity.achievements.find_or_initialize_by(user_id: @user.id)
        achievement.save
      end
      AssessmentAttempt.create(assessment:, user: @user, accepted_conditions: true)
      UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(assessment.class_marker_test_id, @user.id, params[:score].to_f)
      redirect_to admin_user_path(@user.id)
    end

    # redirect to the audit to add an authoriser after it's created
    def after_resource_updated_path(requested_resource)
      edit_admin_support_audit_path(id: requested_resource.support_audits.last.id)
    end

    def authorized_action?(resource, action_name)
      return false if resource.instance_of?(SupportAudit) && action_name == :edit

      true
    end
  end
end
