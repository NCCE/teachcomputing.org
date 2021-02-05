module Diagnostics
  class PrimaryCertificateController < BaseController
    before_action :authenticate, :questionnaire
    before_action :enrolled?, :completed_diagnostic?, only: %i[show update]

    steps :question_1, :question_2, :question_3, :question_4

    def show
      @programme = programme
      @step = step
      @steps = steps
      @answer = answer_for_current_step

      render_wizard
    end

    def update
      response = questionnaire_response
      store_response response
      jump_to_latest response
      response.transition_to(:complete) if next_step == :wicked_finish.to_s &&
                                           questionnaire_response.answers.count == steps.count - 1

      render_wizard response unless completed_diagnostic?
    end

    private

      def programme
        Programme.find_by(slug: 'primary-certificate')
      end

      def questionnaire
        Questionnaire.find_by!(slug: 'primary-certificate-enrolment-questionnaire')
      end

      def enrolled?
        redirect_to primary_path unless programme.user_enrolled?(current_user)
      end
  end
end
