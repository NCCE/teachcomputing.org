require 'rails_helper'

RSpec.describe StemCourseDetailsScrubber do
  let(:scrubber) { StemCourseDetailsScrubber.new }
  let(:empty_node) { '<p>&nbsp;</p>' }
  let(:text_node) { '<p>Some&nbsp;text</p>' }

  describe '#allowed_node?' do
    it 'does not allow empty nodes with non-breaking-spaces' do
      puts "tags #{scrubber.tags}"
      expect(Rails::Html::sanitize(empty_node, scrubber)).to eq("\u00a0")
    end

    it 'allows non-empty nodes with non-breaking-spaces' do
      expect(Rails::Html::sanitize(text_node, scrubber)).to eq("<p>Some\u00a0text</p>")
    end
  end
end
