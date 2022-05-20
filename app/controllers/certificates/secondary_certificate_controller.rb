module Certificates
  class SecondaryCertificateController < ApplicationController
    layout 'full-width'
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete pending]
    before_action :user_enrolled?, only: %i[show complete pending]
    before_action :user_programme_enrolment_pending?, only: %i[show complete]

    def show
      return redirect_to complete_secondary_certificate_path if @programme.user_completed?(current_user)

      assign_achievements
      @programme_activity_groupings = @programme.programme_activity_groupings.where(sort_key: 3..5).order(:sort_key)
      @user_programme_achievements = UserProgrammeAchievements.new(@programme, current_user)
      @badge_tracking_event_category = 'Secondary enrolled'
      @badge_tracking_event_label = 'Secondary badge'
      assign_issued_badge_data

      render :show
    end

    def pending
      return redirect_to complete_secondary_certificate_path if enrolment.current_state == 'complete'

      @complete_achievements = complete_achievements

      render :pending
    end

    def complete
      return redirect_to secondary_certificate_path unless @programme.user_completed?(current_user)

      @complete_achievements = complete_achievements
      @badge_tracking_event_category = 'Secondary complete'
      @badge_tracking_event_label = 'Secondary badge'
      assign_issued_badge_data

      render :complete
    end

    private

      def assign_issued_badge_data
        return unless @programme.badges.any?

        @issued_badge = Credly::Badge.by_programme_badge_template_ids(current_user.id, @programme.badges.pluck(:credly_badge_template_id))
      end

      def enrolment
        current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
      end

      def assign_achievements
        @online_achievements = online_achievements
        @face_to_face_achievements = face_to_face_achievements
      end

      def online_achievements
        current_user.achievements.for_programme(@programme)
                    .with_category(Activity::ONLINE_CATEGORY)
                    .without_category(:action)
                    .not_in_state(:dropped)
                    .sort_complete_first
      end

      def face_to_face_achievements
        current_user.achievements.for_programme(@programme)
                    .with_category(Activity::FACE_TO_FACE_CATEGORY)
                    .without_category(:action)
                    .not_in_state(:dropped)
                    .sort_complete_first
      end

      def complete_achievements
        current_user.achievements.for_programme(@programme)
                    .without_category(:action)
                    .sort_complete_first
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
