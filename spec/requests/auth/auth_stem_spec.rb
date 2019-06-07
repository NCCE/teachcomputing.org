require 'rails_helper'

RSpec.describe AuthController do
  describe 'auth#stem' do
    it 'cannot initiate omniauth login using get' do
      expect {
        get '/auth/stem'
      }.to raise_error(ActionController::RoutingError)
    end
  end
end
