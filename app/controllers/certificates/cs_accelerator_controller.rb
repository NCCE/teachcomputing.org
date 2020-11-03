module Certificates
  class CsAcceleratorController < ApplicationController
    layout 'full-width'
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete]
    before_action :user_enrolled?, only: %i[show complete]

    def show
      return redirect_to complete_cs_accelerator_certificate_path if @programme.user_completed?(current_user)

      assign_assessment_and_achievements

      render :show
    end

    def complete
      return redirect_to cs_accelerator_certificate_path unless @programme.user_completed?(current_user)

      assign_assessment_and_achievements

      render :complete
    end

    private

      def find_programme
        @programme = Programme.cs_accelerator
      end

      def user_enrolled?
        redirect_to cs_accelerator_path unless @programme.user_enrolled?(current_user)
      end

      def assign_assessment_and_achievements
        @user_programme_assessment = user_programme_assessment
        @online_achievements = online_achievements
        @face_to_face_achievements = face_to_face_achievements
      end

      def online_achievements
        current_user.achievements.for_programme(@programme)
                    .not_in_state(:dropped)
                    .with_category(Activity::ONLINE_CATEGORY)
      end

      def face_to_face_achievements
        current_user.achievements.for_programme(@programme)
                    .not_in_state(:dropped)
                    .with_category(Activity::FACE_TO_FACE_CATEGORY)
      end

      def user_programme_assessment
        UserProgrammeAssessment.new(@programme, current_user)
      end
  end
end
