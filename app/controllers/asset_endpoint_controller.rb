class AssetEndpointController < ApplicationController
  def css_endpoint
    redirect_to helpers.asset_pack_path "application.css", type: :stylesheet.to_s
  end
end
