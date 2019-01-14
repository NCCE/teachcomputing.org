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
end
