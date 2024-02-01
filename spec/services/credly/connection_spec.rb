require "rails_helper"

RSpec.describe Credly::Connection do
  describe "#connect" do
    it "is a Faraday::Connection class" do
      expect(described_class.connect.class).to eq Faraday::Connection
    end
  end
end
