module Certificates
  module CSAccelerator
    class UserProgrammePathwayController < ApplicationController
      before_action :authenticate_user!

      def update
        pathway_id = params["pathway_id"]
        pathway = Pathway.find_by(id: pathway_id)
        if pathway.present?
          enrolment = UserProgrammeEnrolment.find_by(user: current_user, programme: Programme.cs_accelerator)
          enrolment.update(pathway_id: pathway_id)
          flash[:notice] = "Your pathway was changed successfully"
        else
          flash[:error] = "Something went wrong updating the pathway"
        end
        redirect_to cs_accelerator_certificate_path
      end
    end
  end
end
