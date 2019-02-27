require 'rails_helper'

RSpec.describe AchievementsController, type: :controller do
  before(:each) do
    allow(controller).to receive(:authenticate_or_request_with_http_basic)
  end

  describe 'before_action' do
    describe '#authenticate' do
      context 'save achievement' do
        it 'authenticate gets called' do
        end
      end

      context 'remove achievement' do
        it 'authenticate does not get called' do
          controller.send(:authenticate)
          expect(controller).not_to have_received(:authenticate_or_request_with_http_basic)
        end
      end
    end
  end
end
