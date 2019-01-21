require 'rails_helper'

RSpec.describe Activity, type: :model do
  let(:activity) { create(:activity) }

  describe 'associations' do
    it 'has_many achievements' do
      expect(activity).to have_many(:achievements)
    end

    it 'has_many users' do
      expect(activity).to have_many(:users).through(:achievements)
    end
  end

  describe 'class methods' do
    describe '#created_ncce_account' do
      it 'returns a record if one is found' do
        activity = create(:activity, :diagnostic_tool)
        expect(Activity.downloaded_diagnostic_tool).to eq activity
      end

      it 'creates a record if one is not found' do
        expect(Activity.downloaded_diagnostic_tool.title).to eq 'Downloaded diagnostic tool'
      end
    end

    describe '#created_ncce_account' do
      it 'returns a record if one is found' do
        activity = create(:activity, :created_ncce_account)
        expect(Activity.created_ncce_account).to eq activity
      end

      it 'creates a record if one is not found' do
        expect(Activity.created_ncce_account.title).to eq 'Created NCCE account'
      end
    end
  end
end
