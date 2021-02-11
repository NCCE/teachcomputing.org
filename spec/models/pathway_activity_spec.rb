require 'rails_helper'

RSpec.describe PathwayActivity, type: :model do
  let(:activity) { create(:activity, category: 'online') }
  let(:pathway_activity) { create(:pathway_activity, activity_id: activity.id) }

  describe 'associations' do
    it 'belongs_to pathway' do
      expect(pathway_activity).to belong_to(:pathway)
    end

    it 'belongs_to activity' do
      expect(pathway_activity).to belong_to(:activity)
    end
  end

  describe '#category' do
    it 'returns the category of the associated activity' do
      expect(pathway_activity.category).to eq('online')
    end
  end
end
