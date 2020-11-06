module Certificates
  class SecondaryCertificateController < ApplicationController
    layout 'full-width'
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete pending]
    before_action :user_enrolled?, only: %i[show complete pending]

    def show
      return redirect_to complete_secondary_certificate_path if @programme.user_completed?(current_user)

      @user_programme_achievements = UserProgrammeAchievements.new(@programme, current_user)
      render :show
    end

    def complete
      return redirect_to secondary_certificate_path unless @programme.user_completed?(current_user)

      @user_programme_achievements = UserProgrammeAchievements.new(@programme, current_user)

      @complete_achievements = current_user.achievements.without_category('action')
                                           .for_programme(@programme).sort_complete_first

      render :complete
    end

    def pending
      return redirect_to complete_secondary_certificate_path if enrolment.current_state == 'complete'

      @enrolment = current_user.user_programme_enrolments.find_by(programme_id: @programme.id)

      render :pending
    end

    private

      def enrolment
        current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
      end

      def find_programme
        @programme = Programme.enrollable.find_by!(slug: params[:slug])
      end

      def user_enrolled?
        redirect_to secondary_path unless @programme.user_enrolled?(current_user)
      end
  end
end
