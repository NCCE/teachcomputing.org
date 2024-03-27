require "rails_helper"

RSpec.describe PagesController do
  describe "GET #contributing-partners" do
    before do
      get contributing_partners_path
    end

    it "shows the page" do
      expect(response).to render_template("pages/contributing-partners")
    end
  end
end
