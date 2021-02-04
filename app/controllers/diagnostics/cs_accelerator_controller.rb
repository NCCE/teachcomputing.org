module Diagnostics
  class CSAcceleratorController < BaseController
    before_action :authenticate, :questionnaire
    before_action :enrolled?, :completed_diagnostic?, only: %i[show update]

    steps :question_1, :question_2, :question_3, :question_4, :question_5

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
      transition_to_complete response

      render_wizard response unless completed_diagnostic?
    end

    private

      def programme
        @programme ||= Programme.find_by(slug: 'cs-accelerator')
      end

      def questionnaire
        @questionnaire ||= Questionnaire.find_by!(slug: 'cs-accelerator-enrolment-questionnaire')
      end

      def transition_to_complete(response)
        response.transition_to(:complete) if next_step == :wicked_finish.to_s ||
                                             (@step == :question_1 && diagnostic_params[:question_1] == '1')
      end

      def enrolled?
        redirect_to cs_accelerator_path unless programme.user_enrolled?(current_user)
      end
  end
end
