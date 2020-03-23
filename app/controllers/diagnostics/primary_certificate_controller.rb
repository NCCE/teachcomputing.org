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
    create_questionnaire_response
    render_wizard
  end

  def update
    @step = step
    @steps = steps
    @programme = programme

    response = get_questionnaire_response
    current_step = "question_#{response.current_question}".to_sym
    answer = diagnostic_params[current_step]

    if answer.nil?
      jump_to(current_step)
    else
      response.answer_current_question(answer)
      response.transition_to(:complete) if step == Wicked::FINISH_STEP
    end

    render_wizard
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
end
