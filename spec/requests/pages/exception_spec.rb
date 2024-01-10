require "rails_helper"

RSpec.describe PagesController do
  describe "#exception" do
    context "404" do
      before do
        get "/404"
      end

      it "has a status code of 404" do
        expect(response.status).to eq 404
      end
    end

    context "422" do
      before do
        get "/422"
      end

      it "has a status code of 422" do
        expect(response.status).to eq 422
      end
    end

    context "500" do
      before do
        get "/500"
      end

      it "has a status code of 500" do
        expect(response.status).to eq 500
      end
    end
  end
end
