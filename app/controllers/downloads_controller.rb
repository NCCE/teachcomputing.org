class DownloadsController < ApplicationController
  # @name POST /downloads
  # @note Allows downloads of static assets to be recorded
  # @example
  # Usage in a view: <%= link_to 'CSA Handbook', downloads_path(name: 'CSA Handbook', uri: 'https://static.../,,.pdf'),method: :post %>
  def create
    aggregate_download = AggregateDownload.find_or_create_by(uri: params[:uri])

    aggregate_download.with_lock do
      aggregate_download.increment(:count)
      aggregate_download.save
    end

    download = Download.new
    download.user_id = current_user.id if current_user.present?
    aggregate_download.downloads << download

    if download.save
      redirect_to aggregate_download.uri
    else
      flash[:error] = "There was a problem creating download. Please contact support"
    end
  end
end
