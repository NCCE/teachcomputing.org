require "rails_helper"

RSpec.describe Api::CacheController do
  let(:token_headers) { {HTTP_AUTHORIZATION: "Bearer secret", HTTP_CONTENT_TYPE: "application/json"} }

  context "token is not passed" do
    describe "DELETE #destroy" do
      before do
        delete "/api/cache/", params: {resource: "unit", identifier: "unit1"}, headers: nil
      end

      it "returns 401 status" do
        expect(response.status).to eq 401
      end
    end
  end

  context "when the correct token is passed" do
    describe "GET #show" do
      before do
        delete "/api/cache/", params: {resource: "unit", identifier: "unit1"}, headers: token_headers
      end

      it "returns 204 status" do
        expect(response.status).to eq 204
      end
    end
  end
end
