require 'rails_helper'

RSpec.describe Pathway, type: :model do
  let(:pathway) { create(:pathway) }

  describe 'associations' do
    it 'belongs_to programme' do
      expect(pathway).to belong_to(:programme)
    end

    it 'has_many user_programme_enrolments' do
      expect(pathway).to have_many(:user_programme_enrolments)
    end

    it 'has_many pathway_activities' do
      expect(pathway).to have_many(:pathway_activities)
    end
  end
end
