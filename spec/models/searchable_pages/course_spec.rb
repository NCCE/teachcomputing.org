require "rails_helper"

RSpec.describe SearchablePages::Course, type: :model do
  describe "#url" do
    it "should return the url json property" do
      page = create(:searchable_pages_course, stem_activity_code: "CP123")
      expect(page.url).to eq Rails.application.routes.url_helpers.course_path("CP123")
    end
  end
end
