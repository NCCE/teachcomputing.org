class Activities::DownloadsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :track_download, only: [:show]

  def show
    redirect_to file_path, disposition: 'inline'
  end

  private

    def file_path
      "#{ENV.fetch('STATIC_FILE_PATH')}/#{params[:file][:name]}"
    end

    def activity
      Activity.find_by(id: params[:id])
    end

    def track_download
      achievement = Achievement.find_or_create_by!(user_id: current_user.id, activity_id: activity.id)
      achievement.set_to_complete
    end
end
