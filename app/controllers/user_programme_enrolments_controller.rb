class UserProgrammeEnrolmentsController < ApplicationController
  before_action :set_programme, :set_user, :authenticate_user!, only: [:create]

  def create
    enrolment = UserProgrammeEnrolment.new(user_programme_enrolment_params)

    if enrolment.save
      flash[:notice] = "Congrats you have enrolled on #{@programme.title}"
      redirect_to programme_path(slug: @programme.slug)

    else
      flash[:error] = 'Whoops something went wrong'
      redirect_to dashboard_path
    end
  end

  private

    def set_programme
      @programme = Programme.find_by!(id: params[:user_programme_enrolment][:programme_id])
    end

    def set_user
      @user = User.find_by!(id: params[:user_programme_enrolment][:user_id])
    end

    def user_programme_enrolment_params
      params.require(:user_programme_enrolment).permit(:user_id, :programme_id)
    end
end
