class AssetEndpointController < ApplicationController
  def css_endpoint
    redirect_to "#{helpers.asset_pack_path "application.css", type: :stylesheet}"
  end
end

