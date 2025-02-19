module Certificates
  class PrimaryCertificateController < ApplicationController
    layout "full-width"
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show]
    before_action :user_enrolled?, only: %i[show]
    after_action :discourage_caching

    def show
      @community_groups = @programme.programme_activity_groupings.community.order(:sort_key)

      user_enrolment

      @status_message = if @user_enrolment.in_state?(:complete) || @user_enrolment.in_state?(:pending)
        "Certificate completed"
      end

      render :show
    end

    private

    def user_enrolment
      @user_enrolment ||= current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
    end

    def find_programme
      @programme = Programme.primary_certificate
    end

    def user_enrolled?
      redirect_to cms_page_path("primary-certificate") unless @programme.user_enrolled?(current_user)
    end
  end
end
