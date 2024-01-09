require "rails_helper"

RSpec.describe Api::ActivitiesController do
  let!(:activities) { create_list(:activity, 10) }
  let(:token_headers) do
    {HTTP_AUTHORIZATION: "Bearer secret", HTTP_CONTENT_TYPE: "application/json"}
  end

  context "token is not passed" do
    describe "GET #show" do
      before do
        get "/api/activities/", headers: nil
      end

      it "returns 401 status" do
        expect(response.status).to eq 401
      end
    end
  end

  context "when the correct token is passed" do
    describe "GET #show" do
      before do
        get "/api/activities/", headers: token_headers
      end

      it "returns 201 status" do
        expect(response.status).to eq 200
      end

      it "returns the 10 activities" do
        expect(JSON.parse(response.body).count).to eq 10
      end
    end
  end
end
