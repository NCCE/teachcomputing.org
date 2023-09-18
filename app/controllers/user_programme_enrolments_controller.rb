class UserProgrammeEnrolmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :user_has_existing_enrolment?, only: [:create]

  def create
    enroller = Programmes::UserEnroller.new(user_programme_enrolment_params)
    programme = Programme.find_by!(id: params[:user_programme_enrolment][:programme_id])
    if enroller.call
      flash[:notice] = "Congratulations, you have enrolled on our #{programme.title}"
      redirect_to programme.path
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

  def destroy_message_flags_primary_pathway_migrated
    enrolment = current_user
      .user_programme_enrolments
      .find_by!(programme: Programme.primary_certificate)

    unless enrolment.update(message_flags_primary_pathway_migrated: nil)
      flash[:error] = "Failed to clear information popup"
    end

    redirect_to Programme.primary_certificate.path
  end

  private

    def user_programme_enrolment_params
      params.require(:user_programme_enrolment).permit(:user_id, :programme_id, :pathway_slug)
    end

    def user_has_existing_enrolment?
      enrolment = UserProgrammeEnrolment.find_by(user_id: user_programme_enrolment_params[:user_id], programme_id: user_programme_enrolment_params[:programme_id])
      return unless enrolment

      if enrolment.in_state?(:unenrolled)
        enrolment.transition_to(:enrolled)
        enrolment.update_attribute(:auto_enrolled, false)
        flash[:notice] = "Congratulations, you have enrolled on our #{enrolment.programme.title}"
      end

      redirect_to enrolment.programme.path
    end
end
