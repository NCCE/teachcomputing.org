require 'rails_helper'

RSpec.describe PathwayActivity, type: :model do
  let(:activity) { create(:activity) }
  let(:pathway_activity) { create(:pathway_activity, activity_id: activity.id) }

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
      expect(pathway_activity.activity_type).to eq('face-to-face')
    end

    it 'is updated when the Activity is updated' do
      activity.category = :online
      activity.save
      expect(pathway_activity.activity_type).to eq('online')
    end
  end
end
