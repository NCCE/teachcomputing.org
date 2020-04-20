require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  before(:each) do
    allow(controller).to receive(:authenticate_or_request_with_http_basic)
  end

  describe 'before_action' do
    describe '#authenticate' do
      context 'when BASIC_AUTH_PASSWORD is set' do
        it 'authenticate gets called' do
          allow(ENV).to receive(:[]).with('BASIC_AUTH_PASSWORD').and_return('password')
          controller.send(:authenticate)
          expect(controller).to have_received(:authenticate_or_request_with_http_basic)
        end
      end

      context 'when BASIC_AUTH_PASSWORD is not set' do
        it 'authenticate does not get called' do
          controller.send(:authenticate)
          expect(controller).not_to have_received(:authenticate_or_request_with_http_basic)
        end
      end
    end

    describe '#s_10_hours_enabled' do
      context 'when true' do
        it 'assigns instance variable cs_10_hours_enabled to true' do
          ENV['CSA_10_HOUR_JOURNEY_ENABLED'] = 'true'
          controller.send(:cs_10_hours_enabled)
          expect(controller.cs_10_hours_enabled).to eq true
        end
      end

      context 'when false' do
        it 'assigns instance variable cs_10_hours_enabled to false' do
          ENV['CSA_10_HOUR_JOURNEY_ENABLED'] = 'false'
          controller.send(:cs_10_hours_enabled)
          expect(controller.cs_10_hours_enabled).to eq false
        end
      end
    end
  end
end
