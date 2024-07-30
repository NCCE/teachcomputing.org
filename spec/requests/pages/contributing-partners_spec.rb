require "rails_helper"

RSpec.describe PagesController do
  describe "GET #contributing-partners" do
    before do
      get "/contributing-partners"
    end

    it "redirects to the get involved page" do
      expect(response).to redirect_to(get_involved_path)
    end
  end
end
