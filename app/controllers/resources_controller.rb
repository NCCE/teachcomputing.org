class ResourcesController < ApplicationController
  layout 'full-width'

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
end
