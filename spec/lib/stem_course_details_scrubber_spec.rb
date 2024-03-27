require "rails_helper"

RSpec.describe StemCourseDetailsScrubber do
  let(:scrubber) { StemCourseDetailsScrubber.new }

  describe "#allowed_node?" do
    it "does not allow empty nodes with non-breaking-spaces" do
      expect(Loofah.scrub_fragment("<p>&nbsp;</p>", scrubber).to_s).to eq("")
    end

    it "allows non-empty nodes with non-breaking-spaces" do
      expect(Loofah.scrub_fragment("<p>Some&nbsp;text</p>", scrubber).to_s).to eq("<p>Some\u00a0text</p>")
    end
  end
end
