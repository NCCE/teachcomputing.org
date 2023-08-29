require 'rails_helper'

RSpec.describe PathwayHelper do
  describe '#should_show_other_pathways?' do
    context 'when provided a primary certificate programme' do
      let(:programme) { create(:primary_certificate) }

      it 'should return false' do
        expect(helper.should_show_other_pathways?(programme)).to be false
      end
    end

    context 'when provided a secondary certificate programme' do
      let(:programme) { create(:secondary_certificate) }

      it 'should return true' do
        expect(helper.should_show_other_pathways?(programme)).to be true
      end
    end
  end

  describe '#should_show_funding?' do
    context 'when provided a primary certificate programme' do
      let(:programme) { create(:primary_certificate) }

      it 'should return true' do
        expect(helper.should_show_funding?(programme)).to be true
      end
    end

    context 'when provided a secondary certificate programme' do
      let(:programme) { create(:secondary_certificate) }

      it 'should return false' do
        expect(helper.should_show_funding?(programme)).to be false
      end
    end
  end
end
