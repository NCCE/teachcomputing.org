require "rails_helper"

RSpec.describe Achiever::Connection do
  describe "#api" do
    it "is a Faraday::Connection class" do
      expect(described_class.api.class).to eq Faraday::Connection
    end

    it "has a proxy set" do
      expect(described_class.api.proxy.host).not_to eq nil
    end
  end
end
