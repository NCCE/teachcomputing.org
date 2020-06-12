class ResourcesController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!, only: [:show]

  def index
    render :index
  end

  def show
    redirect_url = URI.decode_www_form_component(params[:redirect_url])

    if helpers.safe_redirect_url(redirect_url)
      resource_user = track_resources!
      ScheduleUserResourcesFeedbackJob.set(wait_until: Date.today.next_week.noon + 1.day).perform_later(resource_user.user, params[:year]) if resource_user.counter == 1
      return redirect_to redirect_url
    else
      return redirect_to root_path
    end
  end

  private

    def track_resources!
      resource_user = ResourceUser.find_or_create_by!(user_id: current_user.id, resource_year: params[:year])
      resource_user.counter = resource_user.counter + 1
      resource_user.save
      resource_user
    end
end
