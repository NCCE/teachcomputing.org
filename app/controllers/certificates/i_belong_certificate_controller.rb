module Certificates
  class IBelongCertificateController < ApplicationController
    layout 'full-width'
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete pending]
    before_action :user_enrolled?, only: %i[show complete pending]
    before_action :user_programme_enrolment_pending?, only: %i[show complete]

    def show
      return redirect_to complete_i_belong_certificate_path if @programme.user_completed?(current_user)

      assign_achievements
      @professional_development_groups = @programme.programme_activity_groupings.where(sort_key: 1..2).order(:sort_key)
      @community_groups = @programme.programme_activity_groupings.where(sort_key: 3..5).order(:sort_key)
      @badge_tracking_event_category = 'I belong enrolled'
      @badge_tracking_event_label = 'I belong badge'
      assign_issued_badge_data

      render :show
    end

    def pending
      return redirect_to complete_i_belong_certificate_path if enrolment.current_state == 'complete'

      @complete_achievements = complete_achievements

      render :pending
    end

    def complete
      return redirect_to i_belong_certificate_path unless @programme.user_completed?(current_user)

      @complete_achievements = complete_achievements
      @badge_tracking_event_category = 'I belong complete'
      @badge_tracking_event_label = 'I belong badge'
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
        @online_achievements = user_achievements(Activity::ONLINE_CATEGORY)
        @face_to_face_achievements = user_achievements(Activity::FACE_TO_FACE_CATEGORY)
        @community_achievements = user_achievements(Activity::COMMUNITY_CATEGORY)
      end

      def user_achievements(category)
        current_user.achievements.for_programme(@programme).with_category(category)
                    .without_category(:action)
                    .not_in_state(:dropped)
                    .sort_complete_first
      end

      def complete_achievements
        current_user.achievements.for_programme(@programme)
                    .without_category(:action)
                    .in_state(:complete)
      end

      def find_programme
        @programme = Programme.i_belong_certificate
      end

      def user_enrolled?
        redirect_to i_belong_path unless @programme.user_enrolled?(current_user)
      end

      def user_programme_enrolment_pending?
        redirect_to pending_i_belong_certificate_path if enrolment.in_state?(:pending)
      end
  end
end
