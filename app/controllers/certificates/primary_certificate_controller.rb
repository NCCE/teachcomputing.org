module Certificates
  class PrimaryCertificateController < ApplicationController
    layout 'full-width'
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete pending]
    before_action :user_enrolled?, only: %i[show complete pending]
    before_action :user_completed_diagnostic?, only: %i[show]
    before_action :user_programme_enrolment_pending?, only: %i[show complete]

    def show
      @user_programme_achievements = UserProgrammeAchievements.new(@programme, current_user)
      render "programmes/#{@programme.slug}/show"
    end

    def complete
      return redirect_to programme_path(@programme.slug) unless @programme.user_completed?(current_user)

      @user_programme_achievements = UserProgrammeAchievements.new(@programme, current_user)

      @complete_achievements = current_user.achievements.without_category('action')
                                           .without_category('diagnostic')
                                           .for_programme(@programme).sort_complete_first

      render "programmes/#{@programme.slug}/complete"
    end

    def pending
      return redirect_to programme_complete_path(@programme.slug) if enrolment.current_state == 'complete'

      @complete_achievements = current_user.achievements.without_category('action')
                                           .without_category('diagnostic')
                                           .for_programme(@programme).sort_complete_first

      @enrolment = current_user.user_programme_enrolments.find_by(programme_id: @programme.id)

      render "programmes/#{@programme.slug}/pending"
    end

    private

      def enrolment
        current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
      end

      def find_programme
        @programme = Programme.enrollable.find_by!(slug: 'primary-certificate')
      end

      def user_completed_diagnostic?
        questionnaire = Questionnaire.find_by(slug: 'primary-certificate-enrolment-questionnaire')
        response = QuestionnaireResponse.find_by(user: current_user, questionnaire: questionnaire)
        return true if response&.current_state == 'complete'

        # Navigate directly to the last question reached, or question_1.
        question = response&.current_question ? "question_#{response.current_question}" : 'question_1'
        redirect_to primary_certificate_diagnostic_path(question.to_sym)
      end

      def user_enrolled?
        redirect_to "/#{@programme.slug}" unless @programme.user_enrolled?(current_user)
      end

      def user_programme_enrolment_pending?
        redirect_to programme_pending_path(@programme.slug) if enrolment.current_state == 'pending'
      end
  end
end
