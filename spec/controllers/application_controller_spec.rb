require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  before(:each) do
    allow(controller).to receive(:authenticate_or_request_with_http_basic)
  end

  describe "before_action" do
    describe "#authenticate" do
      context "when BASIC_AUTH_PASSWORD is set" do
        it "authenticate gets called" do
          allow(ENV).to receive(:[]).with("BASIC_AUTH_PASSWORD").and_return("password")
          controller.send(:authenticate)
          expect(controller).to have_received(:authenticate_or_request_with_http_basic)
        end
      end

      context "when BASIC_AUTH_PASSWORD is not set" do
        it "authenticate does not get called" do
          controller.send(:authenticate)
          expect(controller).not_to have_received(:authenticate_or_request_with_http_basic)
        end
      end
    end
  end
end
