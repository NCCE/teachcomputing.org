require 'rails_helper'

RSpec.describe ResourceUser, type: :model do
  let(:resource_year) { create(:resource_year) }

  describe 'validations' do
    before do
      resource_year
    end

    it { is_expected.to validate_uniqueness_of(:user_id).case_insensitive.scoped_to(:resource_year) }
  end

  describe 'associations' do
    it 'belongs to user' do
      expect(resource_year).to belong_to(:user)
    end

    it 'has many resources' do
      expect(user).to have_many(:resource_year)
    end
  end
end
