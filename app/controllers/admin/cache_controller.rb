module Admin
  class CacheController < AdminController
    def destroy
      CacheInvalidator.new(
        resource: params[:resource],
        identifier: params[:identifier]
      ).run

      head :no_content
    end
  end
end
