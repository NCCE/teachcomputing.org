require "rails_helper"

RSpec.describe Cms::Models::TextComponents::RichHeader do
  let(:blocks_plain_text) {
    [
      {
        type: "paragraph",
        children: [
          {text: "I am some text", type: "text"}
        ]
      }
    ]
  }

  let(:two_blocks_plain_text) {
    [
      {
        type: "paragraph",
        children: [
          {text: "first block", type: "text"}
        ]
      },
      {
        type: "paragraph",
        children: [
          {text: "second block", type: "text"}
        ]
      }

    ]
  }

  let(:blocks_with_italics) {
    [
      {
        type: "paragraph",
        children: [
          {text: "I am some text followed by", type: "text"},
          {type: "text", text: "Italic text", italic: true}
        ]
      }
    ]
  }

  before do
  end

  it "should extract text when only one child" do
    hib = Cms::Models::TextComponents::RichHeader.new(blocks: blocks_plain_text)
    expect(hib.plain_string).to eq("I am some text")
  end

  it "should extract text when mulitple children" do
    hib = Cms::Models::TextComponents::RichHeader.new(blocks: blocks_with_italics)
    expect(hib.plain_string).to eq("I am some text followed by Italic text")
  end

  context "with_multiple blocks" do
    before do
      @header_with_mutliple_blocks = Cms::Models::TextComponents::RichHeader.new(blocks: two_blocks_plain_text)
    end
    it "plain string should ignore second block" do
      expect(@header_with_mutliple_blocks.plain_string).to eq("first block")
    end
  end
end
