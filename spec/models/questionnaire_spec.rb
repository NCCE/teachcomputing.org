require 'rails_helper'

RSpec.describe Questionnaire, type: :model do
  let(:questionnaire) { create(:questionnaire) }

  describe 'associations' do
    it 'belongs to a programme' do
      expect(questionnaire).to belong_to(:programme)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:title) }
  end
end
