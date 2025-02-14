require "rails_helper"

RSpec.describe Admin::ReportsController, type: :request do
  let(:admin_user) { create(:user, email: "admin@example.com") }
  let!(:primary_certificate) { create(:primary_certificate) }
  let!(:programme_activity_grouping) { create(:programme_activity_grouping, programme: primary_certificate) }
  let!(:secondary_certificate) { create(:secondary_certificate) }
  let!(:i_belong_certificate) { create(:i_belong) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("admin@example.com")
  end

  describe "GET #index" do
    before do
      get admin_reports_path
    end

    it "should be successful" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #by_programme" do
    before do
      get by_programme_admin_reports_path, params: {programme_id: primary_certificate.id}
    end

    it "should be successful" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #report_results" do
    let(:query_mock) {
      mock = instance_double(Programmes::ProgressQuery)
      allow(mock).to receive(:call)
      mock
    }

    it "should be successful" do
      post report_results_admin_reports_path, params: {
        programme_id: primary_certificate.id,
        query: {
          state: :active,
          enrolled: 1
        }
      }
      expect(response).to have_http_status(:success)
    end

    it "should have called the service" do
      expect(Programmes::ProgressQuery).to receive(:new).and_return(query_mock)
      post report_results_admin_reports_path, params: {
        programme_id: primary_certificate.id,
        query: {
          state: :active,
          enrolled: 1,
          programme_activity_groupings: [primary_certificate.programme_activity_groupings.first.id]
        }
      }
    end

    it "should redirect to by_programme if not query" do
      post report_results_admin_reports_path, params: {
        programme_id: primary_certificate.id
      }
      expect(response).to redirect_to(by_programme_admin_reports_path(programme_id: primary_certificate.id))
    end
  end
end
