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
      render :show
    end

    def complete
      return redirect_to primary_certificate_path unless @programme.user_completed?(current_user)

      @user_programme_achievements = user_programme_achievements
      @complete_achievements = complete_achievements

      render :complete
    end

    def pending
      return redirect_to complete_primary_certificate_path if user_enrolment.in_state?(:complete)

      @complete_achievements = complete_achievements
      @enrolment = user_enrolment

      render :pending
    end

    private

      def user_enrolment
        @user_enrolment ||= current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
      end

      def find_programme
        @programme = Programme.primary_certificate
      end

      def user_completed_diagnostic?
        questionnaire = Questionnaire.find_by(slug: 'primary-certificate-enrolment-questionnaire')
        response = QuestionnaireResponse.find_by(user: current_user, questionnaire: questionnaire)
        return true if response&.current_state == 'complete'

        # Navigate directly to the last question reached, or question_1.
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
