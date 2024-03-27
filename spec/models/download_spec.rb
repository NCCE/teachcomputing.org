require "rails_helper"

RSpec.describe Download, type: :model do
  let(:download) { create(:download) }

  describe "associations" do
    it "belongs to an aggregate download" do
      expect(download).to belong_to(:aggregate_download)
    end
  end
end
