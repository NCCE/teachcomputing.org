module Certificates
  module IBelong
    class AutoEnrolmentsController < ApplicationController
      include ConfirmsUnenrolment

      private

      def find_enrolment
        current_user.user_programme_enrolments.find_by(programme: Programme.i_belong)
      end

      def unenrol_programme_name
        Programme.i_belong.certificate_name
      end
    end
  end
end
