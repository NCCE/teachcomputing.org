class AssetEndpointController < ApplicationController
    def css_endpoint
      redirect_to "#{helpers.asset_path("application", type: :stylesheet)}"
    end
  end
  