module Api
  class CacheController < ApiController
    def destroy
      CacheInvalidator.new(
        resource: cache_params[:resource],
        identifier: cache_params[:identifier]
      ).run

      head :no_content
    end

    private

    def cache_params
      params.permit(:resource, :identifier, identifier: [], cache: {})
    end
  end
end
