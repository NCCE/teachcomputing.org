module Certificates
  class CertificateController < ApplicationController
    before_action :authenticate_user!
    after_action :discourage_caching

    def show
      return redirect_to programme.path unless programme.user_completed?(current_user)

      generator = CertificateGenerator.new(
        user: current_user,
        programme: programme,
        transition: enrolment.last_transition
      )

      pdf_details = generator.generate_pdf

      send_file(
        pdf_details[:path],
        filename: pdf_details[:filename],
        type: "application/pdf",
        disposition: "inline"
      )
    end

    private

    def programme
      @programme ||= Programme.enrollable.find_by!(slug: params[:slug])
    end

    def enrolment
      current_user.user_programme_enrolments.find_by(programme: @programme)
    end
  end
end
