require "rails_helper"

RSpec.describe PagesController do
  describe "GET #supporting-partners" do
    before do
      get "/supporting-partners"
    end

    it "redirects to the get involved page" do
      expect(response).to redirect_to(cms_page_path("get-involved"))
    end
  end
end
