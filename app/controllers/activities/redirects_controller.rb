class Activities::RedirectsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :track_visit, only: [:show]

   def show
    redirect_to params[:redirect][:url].to_s
  end

   private

     def activity
      Activity.find_by(id: params[:id])
    end

     def track_visit
      Achievement.find_or_create_by!(user_id: current_user.id, activity_id: activity.id)
    end
end