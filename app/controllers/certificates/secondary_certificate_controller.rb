module Certificates
  class SecondaryCertificateController < ApplicationController
    layout "full-width"
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete pending]
    before_action :user_enrolled?, only: %i[show complete pending]
    before_action :user_programme_enrolment_pending?, only: %i[show complete]

    def show
      return redirect_to complete_secondary_certificate_path if @programme.user_completed?(current_user)

      assign_achievements

      @pathways = Pathway.ordered_by_programme(@programme.slug).not_legacy
      @available_pathways_for_user = @pathways.filter { |pathway| pathway.slug != user_pathway.slug }

      @professional_development_groups = @programme.programme_activity_groupings.not_community.order(:sort_key)
      @community_groups = @programme.programme_activity_groupings.community.order(:sort_key)

      assign_recommended_activities

      render :show
    end

    def pending
      return redirect_to complete_secondary_certificate_path if enrolment.current_state == "complete"

      @complete_achievements = complete_achievements

      render :pending
    end

    def complete
      return redirect_to secondary_certificate_path unless @programme.user_completed?(current_user)

      @complete_achievements = complete_achievements

      render :complete
    end

    private

    def assign_recommended_activities
      recommended_activities = user_pathway.pathway_activities.includes(:activity)
      @recommended_community_activities = recommended_activities.filter { |pa| pa.activity.category == :community.to_s }
      @recommended_activities = recommended_activities - @recommended_community_activities
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
      achievements = current_user.achievements.belonging_to_programme(@programme).with_category(category)
        .includes(:activity)
        .without_category(:action)
        .not_in_state(:dropped)
        .sort_complete_first

      excluded_ids = @programme.excluded_shared_activity_ids
      achievements = achievements.where.not(activity_id: excluded_ids) if excluded_ids.any?

      achievements
    end

    def complete_achievements
      current_user.achievements.belonging_to_programme(@programme)
        .without_category(:action)
        .in_state(:complete)
    end

    def find_programme
      @programme = Programme.secondary_certificate
    end

    def user_enrolled?
      redirect_to secondary_path unless @programme.user_enrolled?(current_user)
    end

    def user_enrolment
      @user_enrolment ||= current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
    end

    def user_pathway
      @user_pathway ||= user_enrolment&.pathway
    end

    def user_programme_enrolment_pending?
      redirect_to pending_secondary_certificate_path if enrolment.in_state?(:pending)
    end
  end
end
