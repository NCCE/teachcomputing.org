require "rails_helper"

RSpec.describe Achiever::Error do
  let(:error) { described_class.new("I am an error") }

  it "contains a message" do
    expect(error.message).to eq "I am an error"
  end
end
