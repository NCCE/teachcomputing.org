module Diagnostics
  class CSAcceleratorController < BaseController
    before_action :authenticate, :questionnaire
    before_action :enrolled?, :completed_diagnostic?, only: %i[show]

    steps :question_1, :question_2, :question_3, :question_4, :question_5

    def show
      @programme = programme
      @step = step
      @steps = steps
      @answer = answer_for_current_step

      render_wizard nil, template: '/diagnostics/cs_accelerator/questions'
    end

    def update
      response = questionnaire_response
      store_response response

      if finished? || diagnostic_params[:question_1] == '1'
        response.complete!
        redirect_to finish_wizard_path
      else
        jump_to_latest response
        render_wizard response
      end
    end

    private

      def programme
        @programme ||= Programme.find_by(slug: 'cs-accelerator')
      end

      def questionnaire
        @questionnaire ||= Questionnaire.find_by!(slug: 'cs-accelerator-enrolment-questionnaire')
      end

      def enrolled?
        redirect_to cs_accelerator_path unless programme.user_enrolled?(current_user)
      end
  end
end
