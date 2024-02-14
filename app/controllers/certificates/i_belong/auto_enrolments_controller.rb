module Certificates
  module IBelong
    class AutoEnrolmentsController < ApplicationController
      before_action :authenticate_user!, only: %i[destroy]

      def destroy
        enrolment = UserProgrammeEnrolment.find_by(
          programme: Programme.i_belong,
          user: current_user
        )

        if enrolment.present?
          enrolment.transition_to(:unenrolled)
          flash[:notice] = "You have successfully opted out of #{Programme.i_belong.certificate_name}"
        end

        redirect_to dashboard_path
      end
    end
  end
end
