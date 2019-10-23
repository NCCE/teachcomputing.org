class UserProgrammeEnrolmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    enrolment = UserProgrammeEnrolment.new(user_programme_enrolment_params)
    programme = Programme.find_by!(id: params[:user_programme_enrolment][:programme_id])

    if enrolment.save
      case programme.slug
      when 'primary-certificate'
        redirect_to primary_certificate_diagnostic_path(:question_1)
      else
        flash[:notice] = "Congrats you have enrolled on #{programme.title}"
        redirect_to programme_path(slug: programme.slug)
      end

    else
      flash[:error] = 'Whoops something went wrong'
      redirect_to dashboard_path
    end
  end

  private

    def user_programme_enrolment_params
      params.require(:user_programme_enrolment).permit(:user_id, :programme_id)
    end
end
