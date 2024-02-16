module Certificates
  module CSAccelerator
    class AutoEnrolmentsController < ApplicationController
      before_action :authenticate_user!, only: %i[destroy]

      def destroy
        enrolment = UserProgrammeEnrolment.find_by(
          programme: Programme.cs_accelerator,
          user: current_user
        )

        if enrolment.present?
          enrolment.transition_to(:unenrolled)
          flash[:notice] = "You have successfully opted out of the KS3 and GCSE subject knowledge programme"
        end

        redirect_to dashboard_path
      end
    end
  end
end
