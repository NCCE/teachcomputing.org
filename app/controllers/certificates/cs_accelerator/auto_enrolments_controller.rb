module Certificates
  module CSAccelerator
    class AutoEnrolmentsController < ApplicationController
      include ConfirmsUnenrolment

      private

      def find_enrolment
        current_user.user_programme_enrolments.find_by(programme: Programme.cs_accelerator)
      end

      def unenrol_programme_name
        "the KS3 and GCSE subject knowledge programme"
      end
    end
  end
end
