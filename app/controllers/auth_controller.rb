class AuthController < ApplicationController
  def callback
    puts request.env['omniauth.auth']
  end
end
