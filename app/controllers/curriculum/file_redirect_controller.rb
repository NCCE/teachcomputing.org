module Curriculum
  class FileRedirectController < ApplicationController
    def redirect_to_file
      slug = params[:slug]
      file_upload = CurriculumClient::Queries::FileUpload.one(slug).file_upload

      if file_upload && file_upload.file.present?
        redirect_to file_upload.file
      else
        render plain: "File not found", status: :not_found
      end
    end
  end
end
