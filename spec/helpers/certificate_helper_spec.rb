require 'rails_helper'

describe CertificateHelper, type: :helper do
  describe '#format_activity_title' do
    let(:group) { create(:programme_activity_grouping, required_for_completion:, title:) }
    let(:required_for_completion) { 1 }
    let!(:programme_activities) { create_list(:programme_activity, 3, programme_activity_grouping: group) }
    let(:title) { 'Encourage girls into computer science' }

    it 'should make the first word of the title bold' do
      expect(helper.format_activity_title(group)).to start_with '<strong>Encourage</strong> girls'
    end

    context 'when the count for required for completion is not equal to the quantity of activities' do
      context 'when the count required for completion is one' do
        it 'should state the quantity required for completion with correct singlars' do
          expect(helper.format_activity_title(group)).to end_with 'by completing <strong>at least one</strong> activity'
        end
      end

      context 'when the count required for completion is two' do
        let(:required_for_completion) { 2 }

        it 'should state the quantity required for completion with correct plurals' do
          expect(helper.format_activity_title(group)).to end_with 'by completing <strong>at least two</strong> activities'
        end
      end
    end

    context 'when the count for required for completion is equal to the quantity of activities' do
      let(:required_for_completion) { 3 }

      it 'shouldn\'t state how many are required for completion' do
        expect(helper.format_activity_title(group)).to eq '<strong>Encourage</strong> girls into computer science'
      end
    end
  end
end
