module Certificates
  class PrimaryCertificateController < ApplicationController
    layout 'full-width'
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete pending]
    before_action :user_enrolled?, only: %i[show complete pending]
    before_action :user_completed_diagnostic?, only: %i[show]
    before_action :user_programme_enrolment_pending?, only: %i[show complete]

    def show
      return redirect_to complete_primary_certificate_path if @programme.user_completed?(current_user)

      @user_programme_achievements = user_programme_achievements
      @badge_tracking_event_category = 'Primary enrolled'
      @badge_tracking_event_label = 'Primary badge'
      assign_issued_badge_data

      if FeatureFlagService.new.flags[:primary_redesign_enabled]
        assign_programme_activity_groupings
        assign_pathway_recommendations
      end

      if FeatureFlagService.new.flags[:primary_redesign_enabled]
        render template: 'certificates/primary_certificate_v2/show'
      else
        render :show
      end
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

    def pending
      return redirect_to complete_primary_certificate_path if user_enrolment.in_state?(:complete)

      @complete_achievements = complete_achievements
      @enrolment = user_enrolment

      render :pending
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

      def assign_programme_activity_groupings
        @programme_activity_groups_1_to_3 = @programme.programme_activity_groupings.where(sort_key: 1..2).order(:sort_key)
        @programme_activity_group_3 = @programme.programme_activity_groupings.where(sort_key: 3)[0].programme_activities
        @programme_activity_groups_4_to_5 = @programme.programme_activity_groupings.where(sort_key: 4..5).order(:sort_key)
      end

      def assign_pathway_recommendations
        return nil unless user_pathway

        recommended_activities = user_pathway.recommended_activities_for_user(current_user)

        @recommended_activities_for_user = recommended_activities.filter do |pa|
          pa.activity.category != :community.to_s
        end

        @recommended_community_activities_for_user = recommended_activities.filter do |pa|
          pa.activity.category == :community.to_s
        end
      end

      def find_programme
        @programme = Programme.primary_certificate
      end

      def user_completed_diagnostic?
        # return true if FeatureFlagService.new.flags[:primary_redesign_enabled]

        questionnaire = Questionnaire.find_by(slug: 'primary-certificate-enrolment-questionnaire')
        response = QuestionnaireResponse.find_by(user: current_user, questionnaire: questionnaire)
        return true if response&.current_state == 'complete'

        question = response&.current_question ? "question_#{response.current_question}" : 'question_1'
        redirect_to diagnostic_primary_certificate_path(question.to_sym)
      end

      def user_enrolled?
        redirect_to primary_path unless @programme.user_enrolled?(current_user)
      end

      def user_programme_enrolment_pending?
        redirect_to pending_primary_certificate_path if user_enrolment.in_state?(:pending)
      end

      def complete_achievements
        current_user.achievements.without_category('action')
                    .without_category('diagnostic')
                    .for_programme(@programme).sort_complete_first
      end

      def user_programme_achievements
        UserProgrammeAchievements.new(@programme, current_user)
      end
  end
end
