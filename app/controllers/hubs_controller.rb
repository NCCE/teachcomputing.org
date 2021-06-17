class HubsController < ApplicationController
  def index
    @hubs_index = HubsIndex.new(location: params[:location])
  end
end
