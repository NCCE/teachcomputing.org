module Certificates
  class ALevelController < ApplicationController
    layout "full-width"
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete]
    before_action :user_enrolled?, only: %i[show complete]
    before_action :user_programme_enrolment_pending?, only: %i[show complete]
    after_action :discourage_caching

    def show
      return redirect_to complete_a_level_path if @programme.user_completed?(current_user)

      @professional_development_groups = @programme.programme_activity_groupings.not_community.order(:sort_key).includes(programme_activities: :activity)
      @cpd_courses = @professional_development_groups.flat_map(&:programme_activities)

      @assessment = Assessment.find_by(programme: @programme)

      render :show
    end

    def complete
      return redirect_to a_level_path unless @programme.user_completed?(current_user)

      @complete_achievements = complete_achievements

      render :complete
    end

    private

    def enrolment
      current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
    end

    def user_achievements(category)
      current_user.achievements.belonging_to_programme(@programme).with_category(category)
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
      @programme = Programme.a_level
    end

    def user_enrolled?
      redirect_to about_a_level_path unless @programme.user_enrolled?(current_user)
    end

    def user_programme_enrolment_pending?
      redirect_to pending_a_level_path if enrolment.in_state?(:pending)
    end
  end
end
