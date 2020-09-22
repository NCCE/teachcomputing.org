module Admin
  class CacheController < AdminController
    def destroy
      resource = params[:resource]
      identifier = params[:identifier]
      binding.pry

      # if resource is all clear entire cache
      Rails.cache.clear(namespace: 'curriculum') if resource === 'all'

      binding.pry
      # if a key_stage has changed invalidate that key_stage, and any list of
      # all key_stages

      # if a unit has changed invalidate that unit and any list of all units
      # (there isn't one currently)

      head :no_content
    end
  end
end
