module Diagnostics
  module ClassMarker
    class CSAcceleratorController < ApplicationController
      before_action :authenticate_user!, only: [:show]
      before_action :track_visit!, only: [:show]

      def show
        redirect_to helpers.class_marker_diagnostic_url(current_user)
      end

      private

      def activity
        Activity.find_by(id: params[:id])
      end

      def track_visit!
        achievement = Achievement.find_or_create_by!(user_id: current_user.id, activity_id: activity.id)
        achievement.complete!
      end
    end
  end
end
