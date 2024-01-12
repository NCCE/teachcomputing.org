require "rails_helper"

RSpec.describe "Admin::PathwaysController" do
  let(:pathway) { create(:pathway) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")
  end

  describe "GET #index" do
    before do
      get admin_pathways_path
    end

    it "should render correct template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_pathway_path(pathway)
    end

    it "should render correct template" do
      expect(response).to render_template("show")
    end
  end

  describe "PUT #update" do
    before do
      put admin_pathway_path(pathway, params: {
        pathway: {title: "test"}
      })
    end

    it "should redirect to the show page" do
      expect(response).to redirect_to(admin_pathway_path(pathway))
    end
  end
end
