# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin

    def authenticate_admin
      return true if ActiveRecord::Type::Boolean.new.cast(ENV['BYPASS_ADMINISTRATE_CF_AUTH'])

      if cookies[:CF_Authorization].nil?
        flash[:error] = 'Whoops something went wrong'
        redirect_to root_path
      else
        decoded_token = decode_cookie(cookies[:CF_Authorization])
        @admin_email = decoded_token.first['email']
      end
    end

    private

      def decode_cookie(token)
        JWT.decode token, nil, false
      end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
