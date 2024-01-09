require "rails_helper"

RSpec.describe SearchesController do
  describe "GET #show" do
    it "should render template searches/show" do
      get search_path

      expect(response).to render_template("searches/show")
    end

    it "passes a query in param q to SiteSearch" do
      expect(SiteSearch).to receive(:search).with("Hello world", order: nil).and_return(SearchablePage.all)

      get search_path(q: "Hello world")
    end

    it "passes published_newest as order when provided as a query param" do
      expect(SiteSearch).to receive(:search).with("Hello world", order: :published_newest).and_return(SearchablePage.all)

      get search_path(q: "Hello world", order: "published_newest")
    end

    it "passes published_oldest as order when provided as a query param" do
      expect(SiteSearch).to receive(:search).with("Hello world", order: :published_oldest).and_return(SearchablePage.all)

      get search_path(q: "Hello world", order: "published_oldest")
    end
  end
end
