class DownloadsController < ApplicationController
  before_action :set_download, only: [:show, :edit, :update, :destroy]

  # GET /downloads
  def index
    @downloads = Download.all
  end

  # GET /downloads/1
  def show
  end

  # GET /downloads/new
  def new
    @download = Download.new
  end

  # GET /downloads/1/edit
  def edit
  end

  # POST /downloads
  def create
    @download = Download.new(download_params)

    if @download.save
      redirect_to @download, notice: 'Download was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /downloads/1
  def update
    if @download.update(download_params)
      redirect_to @download, notice: 'Download was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /downloads/1
  def destroy
    @download.destroy
    redirect_to downloads_url, notice: 'Download was successfully destroyed.'
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
