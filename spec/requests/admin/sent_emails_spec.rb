require "rails_helper"

RSpec.describe "Admin::SentEmailsController" do
  let!(:sent_email) { create(:sent_email) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")
  end

  describe "GET #index" do
    before do
      get admin_sent_emails_path
    end

    it "should render correct template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_sent_email_path(sent_email)
    end

    it "should render correct template" do
      expect(response).to render_template("show")
    end
  end
end
