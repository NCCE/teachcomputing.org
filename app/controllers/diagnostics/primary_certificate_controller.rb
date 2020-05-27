class Diagnostics::PrimaryCertificateController < ApplicationController
  layout 'full-width'
  include Wicked::Wizard

  before_action :authenticate, :set_questionnaire
  before_action :enrolled?, :completed_diagnostic?, only: [:show]

  steps :question_1, :question_2, :question_3, :question_4

  def show
    @step = step
    @steps = steps
    @programme = programme
    @answer = get_answer_for_current_step

    render_wizard
  end

  def update
    @step = step
    @steps = steps
    @programme = programme
    final_step = next_step == :wicked_finish.to_s
    step_index = get_step_index(@step)
    next_step_index = final_step ? step_index : get_step_index(next_step) # use current step if at the end of wizard
    response = get_questionnaire_response

    response.answer_current_question(step_index, diagnostic_params[@step], next_step_index)

    # Jump to any previously unanswered questions (handles users navigating directly to questions)
    missing = check_answers(response.answers)
    jump_to(missing) if missing && past_step?(missing)

    response.transition_to(:complete) if final_step

    # Save the model and proceed to the next step
    render_wizard(response)
  end

  private

    def create_questionnaire_response
      QuestionnaireResponse.find_or_create_by(user: current_user, programme: programme, questionnaire: @questionnaire)
    end

    def get_questionnaire_response
      QuestionnaireResponse.find_by!(user: current_user, questionnaire: @questionnaire)
    end

    def completed_diagnostic?
      response = QuestionnaireResponse.find_by(user: current_user, questionnaire: @questionnaire)
      return unless response

      redirect_to finish_wizard_path if response.current_state == 'complete'
    end

    def diagnostic_params
      params.require(:diagnostic).permit(:question_1, :question_2, :question_3, :question_4)
    end

    def enrolled?
      redirect_to primary_path unless programme.user_enrolled?(current_user)
    end

    def finish_wizard_path
      programme_path(Programme.primary_certificate.slug)
    end

    def programme
      Programme.find_by(slug: 'primary-certificate')
    end

    def set_questionnaire
      @questionnaire = Questionnaire.find_by!(slug: 'primary-certificate-enrolment-questionnaire')
    end

    def get_step_index(candidate_step)
      steps.index(candidate_step) + 1 if candidate_step
    end

    def get_answer_for_current_step
      response = create_questionnaire_response
      response&.answers[get_step_index(step).to_s]
    end

    def check_answers(answers)
      steps.each { |step|
        step_index = get_step_index(step)
        return step if step_index && !answers.include?(step_index.to_s) # returns the first missing answer
      }
      return nil
    end
end
