class Activities::DownloadsController < ApplicationController
  before_action :track_download

  def show
    redirect_to (file_path), type: params[:file][:type], disposition: 'inline'
  end

  private

  def file_path
    "#{ENV.fetch("STATIC_FILE_PATH")}/#{params[:file][:name]}"
  end

  def activity
    Activity.find_by(id: params[:id])
  end

  def track_download
    Achievement.find_or_create_by!(user_id: current_user.id, activity_id: activity.id)
  end
end
