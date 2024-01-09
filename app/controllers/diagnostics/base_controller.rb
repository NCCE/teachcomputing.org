module Diagnostics
  class BaseController < ApplicationController
    layout "full-width"
    include Wicked::Wizard

    after_action :discourage_caching

    def programme
      raise NotImplementedError
    end

    def questionnaire
      raise NotImplementedError
    end

    def enrolled?
      raise NotImplementedError
    end

    def questionnaire_response
      QuestionnaireResponse.find_or_create_by(
        user: current_user, questionnaire: questionnaire
      )
    end

    def diagnostic_params
      params.require(:diagnostic).permit(wizard_steps) unless :diagnostic.nil?
    end

    def step_index(candidate_step)
      steps.index(candidate_step) + 1 if steps.index(candidate_step)
    end

    def answer_for_current_step
      questionnaire_response.answers[step_index(step).to_s]
    end

    def store_response(response)
      step_index = step_index(@step)
      final_step = next_step == :wicked_finish.to_s
      next_step_index = final_step ? step_index : step_index(next_step)
      response.answer_current_question(step_index, diagnostic_params[@step], next_step_index)
      response.save
    end

    def jump_to_latest(response)
      missing = check_answers response.answers
      jump_to missing if missing && past_step?(missing)
    end

    def check_answers(answers)
      steps.each do |step|
        step_index = step_index(step)
        return step if step_index && !answers.include?(step_index.to_s)
      end
      nil
    end

    def finished?
      questionnaire_response.answers.count == steps.count
    end

    def completed_diagnostic?
      return unless questionnaire_response.present?

      redirect_to finish_wizard_path if questionnaire_response.complete?
    end

    def finish_wizard_path
      programme.path
    end
  end
end
