class ResourcesController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!, only: [:show]
  before_action :track_resources!, only: [:show]

  def index
    render :index
  end

  def show
    redirect_url = URI.decode_www_form_component(params[:redirect_url])
    
    if helpers.whitelist_redirect_url(redirect_url)
      ScheduleUserResourcesFeedbackJob.set(wait: 7.days).perform_later(current_user, params[:year])
      return redirect_to redirect_url
    else
      return redirect_to root_path
    end
  end

  private

    def track_resources!
      resource_user = ResourceUser.find_or_create_by!(user_id: current_user.id, resource_year: resource_year)
    end
end
