module Certificates
  class CSAcceleratorController < ApplicationController
    layout 'full-width'
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete]
    before_action :user_enrolled?, only: %i[show complete]
    before_action :user_completed_diagnostic?, only: %i[show]
    after_action :discourage_caching

    def show
      return redirect_to complete_cs_accelerator_certificate_path if @programme.user_completed?(current_user)

      @csa_dash = CSADash.new(user: current_user)
      @badge_tracking_event_category = 'CSA enrolled'
      @badge_tracking_event_label = 'CSA badge'
      assign_issued_badge_data

      render :show
    end

    def complete
      return redirect_to cs_accelerator_certificate_path unless @programme.user_completed?(current_user)

      user_pathway
      other_programme_pathways_for_user

      assign_assessment_and_achievements
      assign_issued_badge_data

      render :complete
    end

    private

      def assign_issued_badge_data
        return unless @programme.badges.any?

        @issued_badge = Credly::Badge.by_programme_badge_template_ids(current_user.id, @programme.badges.pluck(:credly_badge_template_id))
      end

      def find_programme
        @programme = Programme.cs_accelerator
      end

      def user_enrolment
        @user_enrolment ||= current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
      end

      def user_pathway
        @user_pathway ||= user_enrolment&.pathway
      end

      def other_programme_pathways_for_user
        @other_programme_pathways_for_user ||= @programme.pathways_excluding(user_pathway)
      end

      def user_enrolled?
        redirect_to cs_accelerator_path unless @programme.user_enrolled?(current_user)
      end

      def user_completed_diagnostic?
        questionnaire = Questionnaire.cs_accelerator
        questionnaire_response = QuestionnaireResponse.find_by(user: current_user, questionnaire:)
        return if questionnaire_response.nil?
        return true if questionnaire_response&.current_state == 'complete'

        question = questionnaire_response&.current_question ? "question_#{questionnaire_response.current_question}".to_sym : :question_1
        redirect_to diagnostic_cs_accelerator_certificate_path(question)
      end

      def assign_assessment_and_achievements
        @user_programme_assessment = user_programme_assessment
        @online_achievements = online_achievements
        @face_to_face_achievements = face_to_face_achievements
      end

      def online_achievements
        current_user.achievements.belonging_to_programme(@programme)
                    .not_in_state(:dropped)
                    .with_category(Activity::ONLINE_CATEGORY)
      end

      def face_to_face_achievements
        current_user.achievements.belonging_to_programme(@programme)
                    .not_in_state(:dropped)
                    .with_category(Activity::FACE_TO_FACE_CATEGORY)
      end

      def user_programme_assessment
        UserProgrammeAssessment.new(@programme, current_user)
      end
  end
end
