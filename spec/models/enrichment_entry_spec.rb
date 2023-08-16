require 'rails_helper'

RSpec.describe EnrichmentEntry, type: :model do
  subject { create(:enrichment_entry) }

  it { is_expected.to be_valid }

  context 'when title is nil' do
    it do
      subject.title = nil

      is_expected.not_to be_valid
    end
  end

  context 'when body is nil' do
    it do
      subject.body = nil

      is_expected.not_to be_valid
    end
  end
end
