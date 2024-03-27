require "rails_helper"

RSpec.describe Api::UserProgrammeEnrolmentsController do
  let(:user) { create(:user) }
  let(:enrolment) { create(:user_programme_enrolment, user: user) }
  let(:token_headers) { {HTTP_AUTHORIZATION: "Bearer secret", HTTP_CONTENT_TYPE: "application/json"} }

  context "token is not passed" do
    describe "GET #show" do
      before do
        get "/api/user_programme_enrolments/#{enrolment.id}/", headers: nil
      end

      it "returns 401 status" do
        expect(response.status).to eq 401
      end
    end

    describe "POST #enrolled" do
      before do
        post "/api/user_programme_enrolments/#{enrolment.id}/enrolled", headers: nil
      end

      it "returns 401 status" do
        expect(response.status).to eq 401
      end
    end

    describe "POST #complete" do
      before do
        post "/api/user_programme_enrolments/#{enrolment.id}/complete", headers: nil
      end

      it "returns 401 status" do
        expect(response.status).to eq 401
      end
    end

    describe "POST #flag" do
      before do
        post "/api/user_programme_enrolments/#{enrolment.id}/flag", headers: nil
      end

      it "returns 401 status" do
        expect(response.status).to eq 401
      end
    end
  end

  context "token is valid" do
    describe "GET #show" do
      before do
        get "/api/user_programme_enrolments/#{enrolment.id}/", headers: token_headers
      end

      it "returns 201 status" do
        expect(response.status).to eq 200
      end

      it "returns the enrolment information" do
        expect(JSON.parse(response.body)["id"]).to eq enrolment.id
      end
    end
  end

  describe "POST #enrolled" do
    context "with a state of enrolled" do
      before do
        post "/api/user_programme_enrolments/#{enrolment.id}/enrolled", headers: token_headers
      end

      it "returns 409 status" do
        expect(response.status).to eq 409
      end
    end

    context "with a state other than enrolled" do
      before do
        enrolment.transition_to(:complete)
        post "/api/user_programme_enrolments/#{enrolment.id}/enrolled", headers: token_headers
      end

      it "returns 201 status" do
        expect(response.status).to eq 201
      end

      it "transitions to record to enrolled" do
        expect(enrolment.current_state).to eq "enrolled"
      end
    end
  end

  describe "POST #complete" do
    context "with a state of complete" do
      before do
        enrolment.transition_to(:complete)
        post "/api/user_programme_enrolments/#{enrolment.id}/complete", headers: token_headers
      end

      it "returns 409 status" do
        expect(response.status).to eq 409
      end
    end

    context "with a state of enrolled and not flagged" do
      before do
        post "/api/user_programme_enrolments/#{enrolment.id}/complete", headers: token_headers
      end

      it "returns 201 status" do
        expect(response.status).to eq 201
      end

      it "transitions to record to complete" do
        expect(enrolment.current_state).to eq "complete"
      end
    end

    context "when the record is flagged" do
      before do
        enrolment.update(flagged: true)
        post "/api/user_programme_enrolments/#{enrolment.id}/complete", headers: token_headers
      end

      it "returns 409 status" do
        expect(response.status).to eq 409
      end
    end
  end

  describe "POST #flag" do
    before do
      post "/api/user_programme_enrolments/#{enrolment.id}/flag", headers: token_headers
    end

    it "returns 201 status" do
      expect(response.status).to eq 201
    end

    it "sets the enrolment flag to true" do
      enrolment.reload
      expect(enrolment.flagged).to eq true
    end
  end
end
