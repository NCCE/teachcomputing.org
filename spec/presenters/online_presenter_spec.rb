require 'rails_helper'

RSpec.describe OnlinePresenter do
  let(:empty_presenter) { described_class.new(nil) }

  describe('button_label') do
    it { expect(empty_presenter.button_label).to eq('Find an online course') }
  end

  describe('button_url') do
    it { expect(empty_presenter.button_url).to eq('/courses?location=Online') }
    it { expect(empty_presenter.button_url({ certificate: 'cs-accelerator' })).to eq("/courses?certificate=cs-accelerator&location=Online") }
  end

  describe('completed_text') do
    it { expect(empty_presenter.completed_text(0)).to eq('Completed your first online course') }
  end

  describe('prompt_text') do
    it { expect(empty_presenter.prompt_text(1)).to eq('Complete your second online course') }
  end

  describe('inspect') do
    it { expect(empty_presenter.inspect).to start_with("OnlinePresenter - empty? true") }
  end
end
