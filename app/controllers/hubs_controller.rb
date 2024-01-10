class HubsController < ApplicationController
  layout "full-width"

  def index
    @hubs_index = HubsIndex.new(location: params[:location])
    render :index
  end
end
