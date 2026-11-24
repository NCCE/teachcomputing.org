# Unenrol links are sent by email, so a GET only shows a confirmation page.
# The unenrol itself happens on POST, which is CSRF-protected.
#
# Including controllers define:
#   find_enrolment         - the current user's enrolment to unenrol, or nil
#   unenrol_programme_name - the programme name used in the page and flash messages
module ConfirmsUnenrolment
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user_and_return!, only: %i[confirm_destroy destroy]
    before_action :set_unenrollable_enrolment, only: %i[confirm_destroy destroy]
  end

  def confirm_destroy
    render "user_programme_enrolments/confirm_destroy",
      layout: "full-width",
      locals: {programme: @enrolment.programme, programme_name: unenrol_programme_name, form_path: request.path}
  end

  def destroy
    @enrolment.transition_to(:unenrolled)
    flash[:notice] = "You have successfully opted out of #{unenrol_programme_name}"
    redirect_to dashboard_path
  end

  private

  def set_unenrollable_enrolment
    @enrolment = find_enrolment
    return if @enrolment&.can_transition_to?(:unenrolled)

    flash[:notice] = if @enrolment.nil? || @enrolment.in_state?(:unenrolled)
      "You are not enrolled on #{unenrol_programme_name}"
    else
      "Your enrolment on #{unenrol_programme_name} can't be withdrawn at this stage"
    end
    redirect_to dashboard_path
  end
end
