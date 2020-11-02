module Certificates
  class CsAcceleratorController < ApplicationController
    layout 'full-width'
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete pending]
    before_action :user_enrolled?, only: %i[show complete pending]

    def show
      return redirect_to complete_cs_accelerator_certificate_path if @programme.user_completed?(current_user)

      @user_programme_assessment = UserProgrammeAssessment.new(@programme, current_user)

      @online_achievements = current_user.achievements.for_programme(@programme)
                                         .not_in_state(:dropped)
                                         .with_category(Activity::ONLINE_CATEGORY)
      @face_to_face_achievements = current_user.achievements.for_programme(@programme)
                                               .not_in_state(:dropped)
                                               .with_category(Activity::FACE_TO_FACE_CATEGORY)
      render :show
    end

    def complete
      return redirect_to cs_accelerator_certificate_path unless @programme.user_completed?(current_user)

      @user_programme_assessment = UserProgrammeAssessment.new(@programme, current_user)
      @online_achievements = current_user
                             .achievements.for_programme(@programme)
                             .not_in_state(:dropped)
                             .with_category(Activity::ONLINE_CATEGORY)
      @face_to_face_achievements = current_user
                                   .achievements.for_programme(@programme)
                                   .not_in_state(:dropped)
                                   .with_category(Activity::FACE_TO_FACE_CATEGORY)
      render :complete
    end

    private

      def enrolment
        current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
      end

      def find_programme
        @programme = Programme.cs_accelerator
      end

      def user_enrolled?
        redirect_to cs_accelerator_path unless @programme.user_enrolled?(current_user)
      end
  end
end
