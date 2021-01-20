require 'rails_helper'

RSpec.describe PathwayActivity, type: :model do
  let(:pathway_activity) { create(:pathway_activity) }

  describe 'associations' do
    it 'belongs_to pathway' do
      expect(pathway_activity).to belong_to(:pathway)
    end

    it 'belongs_to activity' do
      expect(pathway_activity).to belong_to(:activity)
    end
  end

  describe 'activity type' do
    it 'is updated when the model is saved' do
      pa = build(:pathway_activity)
      pa.run_callbacks :save
      expect(pa.activity_type).to eq('face-to-face')
    end
  end
end
