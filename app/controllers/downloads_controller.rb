class DownloadsController < ApplicationController
  before_action :set_download, only: [:show, :edit, :update, :destroy]

  # @name POST /downloads
  # @note Allows downloads of static assets to be recorded
  # @example
  # Usage in a view: <%= link_to 'CSA Handbook', downloads_path(name: 'CSA Handbook', uri: 'https://static.../,,.pdf'),method: :post %>
  def create
    @download = Download.new
    @download.uri = params[:uri]
    @download.user_id = current_user.id if current_user.present?

    if @download.save
      redirect_to @download.uri, notice: 'Download was successfully created.'
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_download
      @download = Download.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def download_params
      params.require(:download).permit(:uri, :user_id)
    end
end
