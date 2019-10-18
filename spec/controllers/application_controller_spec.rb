require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:url) { '/test/123' }
  let(:url_fallback) { '/test/456' }

  before(:each) do
    allow(controller).to receive(:authenticate_or_request_with_http_basic)
  end

  describe 'before_action' do
    describe '#authenticate' do
      context 'when BASIC_AUTH_PASSWORD is set' do
        it 'authenticate gets called' do
          ENV.stub(:[]).with('BASIC_AUTH_PASSWORD').and_return('password')
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
  end

  describe '#store_internal_location' do
    before do
      allow_any_instance_of(ActionController::TestRequest).to receive_messages(get?: true, original_fullpath: url)
      controller.store_internal_location
    end

    it 'stores the current request path in the session' do
      expect(session[:forwarding_url]).to eq(url)
    end
  end

  describe '#redirect_back_or' do
    before do
      allow_any_instance_of(described_class).to receive(:redirect_to)
    end

    context 'when forwarding_url is set' do
      before do
        session[:forwarding_url] = url
        controller.redirect_back_or url_fallback
      end

      it 'redirects to the session url' do
        expect(controller).to have_received(:redirect_to).with(url)
      end

      it 'deletes the forwarding url from the session' do
        expect(session[:forwarding_url]).to eq(nil)
      end
    end

    context 'when forwarding_url is not set' do
      before do
        controller.redirect_back_or url_fallback
      end

      it 'redirects to the session url' do
        expect(controller).to have_received(:redirect_to).with(url_fallback)
      end

      it 'deletes the forwarding url from the session' do
        expect(session[:forwarding_url]).to eq(nil)
      end
    end
  end
end
