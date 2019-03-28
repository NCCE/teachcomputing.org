require 'rails_helper'

describe ImportsHelper, type: :helper do
  let(:import) { create(:import) }

  describe('#completed_at?') do
    context 'when completed_at is not nil' do
      it 'returns the completed_at timestamp' do
        date = DateTime.current
        import.completed_at = date
        expect(helper.completed_at?(import)).to eq date.to_formatted_s(:short)
      end
    end

    context 'when completed_at is nil' do
      it 'returns' do
        expect(helper.completed_at?(import)).to eq 'Import pending'
      end
    end
  end
end
