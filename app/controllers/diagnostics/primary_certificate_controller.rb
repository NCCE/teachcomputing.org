class Diagnostics::PrimaryCertificateController < ApplicationController
  include Wicked::Wizard

  before_action :authenticate

  steps :introduction, :question_1, :question_2, :question_3, :question_4

  def show
    render_wizard
  end

  def update
    session[:primary_diagnostic].merge!(diagnostic_params)
    case step
    when Wicked::FINISH_STEP
      achievement = Achievement.create(user_id: current_user.id, activity_id: Programmes::PrimaryCertificate.diagnostic.id)
      achievement.set_to_complete(diagnostic_response: session[:primary_diagnostic], score: score)
    end
    render_wizard
  end

  private
    def diagnostic_params
      params.require(:diagnostic).permit(:question_1, :question_2, :question_3, :question_4)
    end

    def finish_wizard_path
      programme_path(Programme.primary_certificate.slug)
    end

    def score
      puts "Frm the score #{session[:primary_diagnostic]}"
      session[:primary_diagnostic].values.map(&:to_i).inject(:+) / diagnostic_params.values.count
    end
end
