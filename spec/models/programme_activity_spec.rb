require 'rails_helper'

RSpec.describe ProgrammeActivity, type: :model do
  let(:programme_activity) { create(:programme_activity) }

  describe 'associations' do
    it 'belongs to activity' do
      expect(programme_activity).to belong_to(:activity)
    end

    it 'belongs to programme' do
      expect(programme_activity).to belong_to(:programme)
    end

    it 'belongs to programme activity grouping' do
      expect(programme_activity).to belong_to(:programme_activity_grouping).optional(true)
    end
  end

  describe '.legacy' do
    let!(:legacy) { create(:programme_activity, legacy: true) }
    let!(:not_legacy) { create(:programme_activity) }

    it 'should return just legacy PAs' do
      expect(described_class.legacy.to_a).to eq [legacy]
    end
  end

  describe '.not_legacy' do
    let!(:legacy) { create(:programme_activity, legacy: true) }
    let!(:not_legacy) { create(:programme_activity) }

    it 'should return just legacy PAs' do
      expect(described_class.not_legacy.to_a).to eq [not_legacy]
    end
  end
end
