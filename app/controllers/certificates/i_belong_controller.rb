module Certificates
  class IBelongController < ApplicationController
    layout "full-width"
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete pending]
    before_action :user_enrolled?, only: %i[show complete pending]
    before_action :user_programme_enrolment_pending?, only: %i[show complete]
    after_action :discourage_caching

    def show
      return redirect_to complete_i_belong_path if @programme.user_completed?(current_user)

      assign_achievements
      @professional_development_groups = @programme.programme_activity_groupings.not_community.includes(programme_activities: :activity).order(:sort_key)
      set_cpd_courses
      @cpd_group = @professional_development_groups.first
      @cpd_completed = @professional_development_groups.first.user_complete?(current_user)
      @community_groups = @programme.programme_activity_groupings.community.order(:sort_key).includes(:programme_activities)

      @completed_comm_groups, @incomplete_comm_groups = @community_groups.partition { _1.user_complete?(current_user) }

      render :show
    end

    def pending
      return redirect_to complete_i_belong_path if enrolment.current_state == "complete"

      @complete_achievements = complete_achievements

      render :pending
    end

    def complete
      return redirect_to i_belong_path unless @programme.user_completed?(current_user)

      @complete_achievements = complete_achievements

      render :complete
    end

    private

    def enrolment
      current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
    end

    def assign_achievements
      @online_achievements = user_achievements(Activity::ONLINE_CATEGORY)
      @face_to_face_achievements = user_achievements(Activity::FACE_TO_FACE_CATEGORY)
      @community_achievements = user_achievements(Activity::COMMUNITY_CATEGORY)
    end

    def user_achievements(category)
      current_user.achievements
        .includes(:activity)
        .belonging_to_programme(@programme)
        .with_category(category)
        .without_category(:action)
        .not_in_state(:dropped)
        .sort_complete_first
    end

    def complete_achievements
      current_user.achievements.belonging_to_programme(@programme)
        .without_category(:action)
        .in_state(:complete)
    end

    def find_programme
      @programme = Programme.i_belong
    end

    def user_enrolled?
      redirect_to about_i_belong_path unless @programme.user_enrolled?(current_user)
    end

    def user_programme_enrolment_pending?
      redirect_to pending_i_belong_path if enrolment.in_state?(:pending)
    end

    def set_cpd_courses
      user_achievement_activity_ids = current_user
        .achievements
        .in_state(:complete)
        .belonging_to_programme(@programme)
        .pluck(:activity_id)

      completed_courses, not_completed_courses = @professional_development_groups
        .flat_map(&:programme_activities)
        .partition { _1.activity_id.in? user_achievement_activity_ids }

      @cpd_courses =
        if completed_courses.empty?
          not_completed_courses.first(2)
        else
          completed_courses
        end
    end
  end
end
