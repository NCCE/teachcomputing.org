class Diagnostics::PrimaryCertificateController < ApplicationController
  layout 'full-width'
  include Wicked::Wizard

  before_action :authenticate
  before_action :enrolled?, :completed_diagnostic?, only: [:show]

  steps :question_1, :question_2, :question_3, :question_4

  def show
    @step = step
    @steps = steps
    @programme = programme
    render_wizard
  end

  def update
    @step = step
    @steps = steps
    @programme = programme
    session[:primary_diagnostic] = {}
    session[:primary_diagnostic].merge!(diagnostic_params)

    create_diagnositc_achievement if step == Wicked::FINISH_STEP

    render_wizard
  end

  private

    def completed_diagnostic?
      redirect_to finish_wizard_path if programme.user_completed_diagnostic?(current_user)
    end

    def create_diagnositc_achievement
      achievement = Achievement.create(user_id: current_user.id, activity_id: programme.diagnostic.id)
      achievement.set_to_complete(diagnostic_response: session[:primary_diagnostic], score: score)
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

    def score
      session[:primary_diagnostic].values.map(&:to_i).inject(:+) / diagnostic_params.values.count
    end

    def programme
      Programme.find_by(slug: 'primary-certificate')
    end
end
