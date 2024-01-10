require "rails_helper"

RSpec.describe LandingPagesController do
  let!(:cs_accelerator) { create(:cs_accelerator) }
  let!(:primary_certificate) { create(:primary_certificate) }
  let!(:secondary_certificate) { create(:secondary_certificate) }

  describe "#primary_teachers" do
    before do
      get primary_teachers_path
    end

    it "assigns PrimaryLandingPage" do
      expect(assigns(:landing_page)).to be_a(PrimaryLandingPage)
    end

    it "renders the correct template" do
      expect(response).to render_template("landing_pages/show")
    end
  end

  describe "#secondary_teachers" do
    before do
      get secondary_teachers_path
    end

    it "assigns SecondaryLandingPage" do
      expect(assigns(:landing_page)).to be_a(SecondaryLandingPage)
    end

    it "renders the correct template" do
      expect(response).to render_template("landing_pages/show")
    end
  end
end
