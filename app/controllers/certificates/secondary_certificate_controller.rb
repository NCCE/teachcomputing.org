module Certificates
  class SecondaryCertificateController < ApplicationController
    layout 'full-width'
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete pending]
    before_action :user_enrolled?, only: %i[show complete pending]
    before_action :user_programme_enrolment_pending?, only: %i[show complete]

    def show
      return redirect_to complete_secondary_certificate_path if @programme.user_completed?(current_user)

      @programme_activity_groupings = @programme.programme_activity_groupings
      @user_programme_achievements = UserProgrammeAchievements.new(@programme, current_user)
      assign_issued_badge_data

      render :show
    end

    def complete
      return redirect_to secondary_certificate_path unless @programme.user_completed?(current_user)

      @complete_achievements = complete_achievements
      assign_issued_badge_data

      render :complete
    end

    def pending
      return redirect_to complete_secondary_certificate_path if enrolment.current_state == 'complete'

      @complete_achievements = complete_achievements

      render :pending
    end

    private

      def assign_issued_badge_data
        return unless FeatureFlagService.new.flags[:badges_enabled]

        @badge_template = @programme.badges.active.first

        return unless @badge_template

        @issued_badge = Credly::Badge.by_badge_template_id(current_user.id, @badge_template.credly_badge_template_id)
        @badge_tracking_event_category = 'Secondary enrolled'
        @badge_tracking_event_label = 'Secondary badge'
      end

      def enrolment
        current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
      end

      def complete_achievements
        current_user.achievements.without_category('action')
                    .for_programme(@programme).sort_complete_first
      end

      def find_programme
        @programme = Programme.secondary_certificate
      end

      def user_enrolled?
        redirect_to secondary_path unless @programme.user_enrolled?(current_user)
      end

      def user_programme_enrolment_pending?
        redirect_to pending_secondary_certificate_path if enrolment.in_state?(:pending)
      end
  end
end
