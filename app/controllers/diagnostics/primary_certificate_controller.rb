class Diagnostics::PrimaryCertificateController < ApplicationController
  before_action :authenticate

  def show
    render :show
  end

  def create
    achievement = Achievement.create(user_id: current_user.id, activity_id: Programmes::PrimaryCertificate.diagnostic.id)
    achievement.set_to_complete(diagnostic_response: diagnostic_params)
    redirect_to programme_path(Programme.primary_certificate.slug)
  end

  private

    def score
      diagnostic_params.values.map(&:to_i).inject(:+) / diagnostic_params.values.count
    end

    def diagnostic_params
      params.require(:diagnostic).permit(:question_1, :question_2, :question_3, :question_4)
    end
end
