require 'rails_helper'

RSpec.describe OnlinePresenter do
  let(:empty_presenter) { described_class.new(nil) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:presenter) { described_class.new(create(:achievement, programme_id: secondary_certificate.id), secondary_certificate) }

  before do
    secondary_certificate
  end

  describe('button_url') do
    it { expect(empty_presenter.button_url).to eq('/courses?topic=Online') }
    it { expect(empty_presenter.button_url({ certificate: 'cs-accelerator' })).to eq("/courses?certificate=cs-accelerator&topic=Online") }
  end

  describe('completed_text') do
    it { expect(empty_presenter.completed_text(0)).to eq('Completed your first online course') }
  end

  describe('prompt_text') do
    it { expect(empty_presenter.prompt_text(1)).to eq('Complete your second online course') }

    context 'when the the achievement belongs to secondary certificate' do
      it { expect(presenter.prompt_text(1)).to eq('Complete at least one online course') }
    end
  end

  describe('inspect') do
    it { expect(empty_presenter.inspect).to start_with("OnlinePresenter - empty? true") }
  end
end
