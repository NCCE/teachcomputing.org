class Achiever::CacheController < ApplicationController
  skip_before_action :verify_authenticity_token

  def destroy
    Rails.cache.delete(cache_key)
    head :ok
  end

  private

  def cache_key
    "#{cache_params[:workflow_id]}-#{Date.today}"
  end

  def cache_params
    params.require(:cache).permit(:workflow_id)
  end
end
