require "rails_helper"

RSpec.describe OmniAuth::Strategies::Stem do
  subject(:strategy) { described_class.new({}) }

  let(:full_info) {
    {
      "id_token" => "Test",
      "given_name" => "Keymaster of",
      "family_name" => "Gozer",
      "userEmail" => "vince@gozer.com",
      "achiever_contact_no" => "abc123",
      "integrationkey" => 123456
    }
  }

  let(:partial_info) {
    {
      "given_name" => "Keymaster of",
      "family_name" => "Gozer"
    }
  }

  context "with correct fields info returns the correct" do
    before do
      allow(strategy).to receive(:raw_info).and_return(full_info)
    end

    it "first name" do
      expect(strategy.info[:first_name]).to eq("Keymaster of")
    end

    it "last name" do
      expect(strategy.info[:last_name]).to eq("Gozer")
    end

    it "stem user id" do
      expect(strategy.info[:stem_user_id]).to eq(123456)
    end

    it "email" do
      expect(strategy.info[:email]).to eq("vince@gozer.com")
    end

    it "achieverContactNo" do
      expect(strategy.info[:achiever_contact_no]).to eq("abc123")
    end
  end

  context "with missing fields info sets them to nil for" do
    before do
      allow(strategy).to receive(:raw_info).and_return(partial_info)
    end

    it "email" do
      expect(strategy.info[:email]).to be(nil)
    end

    it "achieverContactNo" do
      expect(strategy.info[:achiever_contact_no]).to be(nil)
    end
  end
end
