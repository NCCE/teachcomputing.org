require 'rails_helper'

RSpec.describe DiagnosticPresenter do
  let(:user) { create(:user) }
  let(:empty_presenter) { described_class.new(nil) }

  describe('button_label') do
    it { expect(empty_presenter.button_label).to eq('Use the diagnostic tool') }
  end

  describe('button_url') do
    it { expect(empty_presenter.button_url).to start_with('/certificate/cs-accelerator/diagnostic') }
  end

  describe('completed_text') do
    it { expect(empty_presenter.completed_text(0)).to eq('Used the diagnostic tool') }
  end

  describe('prompt_text') do
    it { expect(empty_presenter.prompt_text(1)).to eq('Use the diagnostic tool') }
  end

  describe('inspect') do
    it { expect(empty_presenter.inspect).to start_with('DiagnosticPresenter - empty? true') }
  end
end
