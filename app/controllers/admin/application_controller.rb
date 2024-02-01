# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include HttpHeaders

    before_action :authenticate_admin
    after_action :discourage_caching

    def authenticate_admin
      return true if ActiveRecord::Type::Boolean.new.cast(ENV.fetch("BYPASS_ADMINISTRATE_CF_AUTH", false)) && !Rails.env.production?

      if cookies[:CF_Authorization].nil?
        flash[:error] = "Whoops something went wrong"
        redirect_to root_path
      else
        decoded_token = decode_cookie(cookies[:CF_Authorization])
        @admin_email = decoded_token.first["email"]
      end
    end

    private

    def decode_cookie(token)
      JWT.decode token, nil, false
    end
  end
end
