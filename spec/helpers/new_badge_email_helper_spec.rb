require "rails_helper"

describe NewBadgeEmailHelper, type: :helper do
  include ActionView::Helpers

  describe("#programme_name") do
    let(:programme) { create(:programme, slug: "primary-certificate") }
    it "returns a string" do
      expect(programme_name(programme)).to be_a(String)
    end
  end
end
