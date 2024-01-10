require "rails_helper"

RSpec.describe AggregateDownload, type: :model do
  let(:aggregate_download) { create(:aggregate_download) }

  describe "associations" do
    it "has many downloads" do
      expect(aggregate_download).to have_many(:downloads)
    end
  end
end
