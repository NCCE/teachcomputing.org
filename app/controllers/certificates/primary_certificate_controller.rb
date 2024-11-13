module Certificates
  class PrimaryCertificateController < ApplicationController
    layout "full-width"
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete pending]
    before_action :user_enrolled?, only: %i[show complete pending]
    before_action :user_programme_enrolment_pending?, only: %i[show complete]
    after_action :discourage_caching

    def show
      @user_courses = user_courses
      @teaching_activities = teaching_activities
      @community_activities = community_activities
      @community_groups = @programme.programme_activity_groupings.community.order(:sort_key)

      @badge_tracking_event_category = "Primary enrolled"
      @badge_tracking_event_label = "Primary badge"

      assign_achievements
      assign_issued_badge_data

      render :show
    end

    def user_courses
      in_progress_achievements = current_user.achievements.in_state(:in_progress, :enrolled).with_courses.order("created_at DESC")
      complete_achievements = current_user.achievements.in_state(:complete).with_courses.order("created_at DESC")

      {
        in_progress: in_progress_achievements.belonging_to_programme(@programme),
        complete: complete_achievements.belonging_to_programme(@programme)
      }
    end

    def teaching_activities
      teaching = @programme.programme_activity_groupings.community.find_by_title("Develop your teaching practice")
      teaching.activities
    end

    def community_activities
      community = @programme.programme_activity_groupings.community.find_by_title("Develop computing in your community")
      community.activities
    end

    def pending
      return redirect_to complete_primary_certificate_path if user_enrolment.in_state?(:complete)

      @complete_achievements = complete_achievements
      @enrolment = user_enrolment

      render :pending
    end

    def complete
      return redirect_to primary_certificate_path unless @programme.user_completed?(current_user)

      @badge_tracking_event_category = "Primary complete"
      @badge_tracking_event_label = "Primary badge"
      @complete_achievements = complete_achievements

      assign_issued_badge_data

      render :complete
    end

    private

    def assign_issued_badge_data
      return unless @programme.badges.any?

      begin
        @issued_badge = Credly::Badge.by_programme_badge_template_ids(current_user.id, @programme.badges.pluck(:credly_badge_template_id))
      rescue Credly::Error
        @issued_badge = nil
      end
    end

    def user_enrolment
      @user_enrolment ||= current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
    end

    def assign_programme_activity_groupings
      @professional_development_groups = @programme.programme_activity_groupings.not_community.order(:sort_key)
      @community_groups = @programme.programme_activity_groupings.community.order(:sort_key)
    end

    def assign_pathway_recommendations
      recommended_activities = user_pathway.pathway_activities.includes(:activity)
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

    def assign_achievements
      @online_achievements = user_achievements(Activity::ONLINE_CATEGORY)
      @face_to_face_achievements = user_achievements(Activity::FACE_TO_FACE_CATEGORY)
      @community_achievements = user_achievements(Activity::COMMUNITY_CATEGORY)
    end

    def user_achievements(category)
      current_user.achievements.belonging_to_programme(@programme)
        .with_category(category)
        .without_category(:action)
        .not_in_state(:dropped)
        .sort_complete_first
    end

    def complete_achievements
      # Diagnostic may still exist for some users, so we must exclude it
      current_user.achievements.belonging_to_programme(@programme)
        .without_category(:action)
        .without_category(:diagnostic)
        .in_state(:complete)
    end
  end
end
