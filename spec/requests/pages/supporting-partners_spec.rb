require "rails_helper"

RSpec.describe PagesController do
  describe "GET #supporting-partners" do
    before do
      get supporting_partners_path
    end

    it "shows the page" do
      expect(response).to render_template("pages/supporting-partners")
    end
  end
end
