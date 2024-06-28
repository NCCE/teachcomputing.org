require "rails_helper"

RSpec.describe Cms::Collection do
  context "with page in range" do
    let(:collection) {
      described_class.new(
        resources: [],
        page: 4,
        page_size: 10,
        page_number: 5,
        total_records: 50
      )
    }
    it "should return the correct next page" do
      expect(collection.next_page).to eq(5)
    end

    it "should return the correct previous page" do
      expect(collection.previous_page).to eq(3)
    end
  end

  context "with page at start of range" do
    let(:collection) {
      described_class.new(
        resources: [],
        page: 1,
        page_size: 10,
        page_number: 5,
        total_records: 50
      )
    }

    it "should return nil for previous page" do
      expect(collection.previous_page).to eq(nil)
    end
  end

  context "with page out of range" do
    let(:collection) {
      described_class.new(
        resources: [],
        page: 100,
        page_size: 10,
        page_number: 5,
        total_records: 50
      )
    }
    it "should return nil for next page" do
      expect(collection.next_page).to eq(nil)
    end

    it "should return the page_number for previous page" do
      expect(collection.previous_page).to eq(5)
    end
  end
end
