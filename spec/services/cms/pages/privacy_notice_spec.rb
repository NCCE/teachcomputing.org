require "rails_helper"

RSpec.describe Cms::Pages::PrivacyNotice do
  before do
  end

  it "should have correct resource_key" do
    expect(described_class.resource_key).to eq("privacy-notice")
  end
end
