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

      render_wizard nil, template: "/diagnostics/cs_accelerator/questions"
    end

    def update
      response = questionnaire_response
      store_response response

      if finished? || diagnostic_params[:question_1] == "1"
        response.complete!
        recommend_pathway
        redirect_to finish_wizard_path
      else
        jump_to_latest response
        render_wizard response
      end
    end

    private

    def programme
      @programme ||= Programme.find_by(slug: "subject-knowledge")
    end

    def questionnaire
      @questionnaire ||= Questionnaire.find_by!(slug: "subject-knowledge-enrolment-questionnaire")
    end

    def recommend_pathway
      upe = UserProgrammeEnrolment.find_by(user_id: current_user.id,
        programme_id: programme.id)
      upe.assign_recommended_pathway(questionnaire_response)
    end

    def enrolled?
      redirect_to cs_accelerator_path unless programme.user_enrolled?(current_user)
    end
  end
end
