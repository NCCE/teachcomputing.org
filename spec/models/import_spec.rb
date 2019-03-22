require 'rails_helper'

RSpec.describe Import, type: :model do
  let(:import) { create(:import) }

  describe 'associations' do
    it 'belongs to activities' do
      expect(import).to belong_to(:activity)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:triggered_by) }
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_inclusion_of(:provider).in_array(['future-learn']) }
  end
end
