module Certificates
  class PrimaryCertificateController < ApplicationController
    layout 'full-width'
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete pending]
    before_action :user_enrolled?, only: %i[show complete pending]
    before_action :user_programme_enrolment_pending?, only: %i[show complete]

    def show
      return redirect_to complete_primary_certificate_path if @programme.user_completed?(current_user)

      @user_programme_achievements = user_programme_achievements
      @badge_tracking_event_category = 'Primary enrolled'
      @badge_tracking_event_label = 'Primary badge'

      assign_achievements
      assign_issued_badge_data

      @pathways = Pathway.ordered_by_programme(@programme.slug)
      @available_pathways_for_user = @pathways.filter { |pathway| pathway.slug != user_pathway.slug } if user_pathway.present?
      assign_programme_activity_groupings
      assign_pathway_recommendations

      render :show
    end

    def pending
      return redirect_to complete_primary_certificate_path if user_enrolment.in_state?(:complete)

      @complete_achievements = complete_achievements
      @enrolment = user_enrolment

      render :pending
    end

    def complete
      return redirect_to primary_certificate_path unless @programme.user_completed?(current_user)

      @user_programme_achievements = user_programme_achievements
      @badge_tracking_event_category = 'Primary complete'
      @badge_tracking_event_label = 'Primary badge'
      @complete_achievements = complete_achievements

      assign_issued_badge_data

      render :complete
    end

    private

      def assign_issued_badge_data
        return unless @programme.badges.any?

        @issued_badge = Credly::Badge.by_programme_badge_template_ids(current_user.id, @programme.badges.pluck(:credly_badge_template_id))
      end

      def user_enrolment
        @user_enrolment ||= current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
      end

      def user_pathway
        @user_pathway ||= user_enrolment&.pathway
      end

      def assign_achievements
        @online_achievements = online_achievements
        @face_to_face_achievements = face_to_face_achievements
      end

      def assign_programme_activity_groupings
        @professional_development_groups = @programme.programme_activity_groupings.where(sort_key: 1..3).order(:sort_key)
        @online_discussion_activity = @programme.programme_activity_groupings.where(sort_key: 3).first&.programme_activities
        @community_groups = @programme.programme_activity_groupings.where(sort_key: 4..5).order(:sort_key)
      end

      def assign_pathway_recommendations
        return nil unless user_pathway

        recommended_activities = user_pathway.pathway_activities
        @recommended_community_activities = recommended_activities.filter { |pa| pa.activity.category == :community.to_s }
        @recommended_activities = recommended_activities - @recommended_community_activities
      end

      def find_programme
        @programme = Programme.primary_certificate
      end

      def user_enrolled?
        redirect_to primary_path unless @programme.user_enrolled?(current_user)
      end

      def user_programme_enrolment_pending?
        redirect_to pending_primary_certificate_path if user_enrolment.in_state?(:pending)
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
        # Diagnostic may still exist for some users, so we must continue excluding it
        current_user.achievements.for_programme(@programme)
                    .without_category(:action)
                    .without_category(:diagnostic)
                    .sort_complete_first
      end

      def user_programme_achievements
        UserProgrammeAchievements.new(@programme, current_user)
      end
  end
end
