class UserProgrammeEnrolmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :user_has_existing_enrolment?, only: [:create]

  def create
    enrolment = UserProgrammeEnrolment.new(user_programme_enrolment_params)
    programme = Programme.find_by!(id: params[:user_programme_enrolment][:programme_id])

    if enrolment.save
      case programme.slug
      when 'primary-certificate'
        redirect_to diagnostic_primary_certificate_path(:question_1)
      else
        flash[:notice] = "Congrats you have enrolled on #{programme.title}"
        redirect_to programme.path
      end

    else
      flash[:error] = 'Whoops something went wrong'
      redirect_to dashboard_path
    end
  end

  def destroy
    enrolment = UserProgrammeEnrolment.find_by!(id: params[:id])

    if enrolment.present?
      enrolment.transition_to(:unenrolled)
      flash[:notice] = "You have successfully opted out of the #{enrolment.programme.title}"
    end

    redirect_to dashboard_path
  end

  private

    def user_programme_enrolment_params
      params.require(:user_programme_enrolment).permit(:user_id, :programme_id)
    end

    def user_has_existing_enrolment?
      enrolment = UserProgrammeEnrolment.find_by(user_programme_enrolment_params)
      return unless enrolment

      if enrolment.in_state?(:unenrolled)
        enrolment.transition_to(:enrolled)
        enrolment.update_attribute(:auto_enrolled, false)
        flash[:notice] = "Congrats you have enrolled on #{enrolment.programme.title}"
      end

      redirect_to enrolment.programme.path
    end
end
