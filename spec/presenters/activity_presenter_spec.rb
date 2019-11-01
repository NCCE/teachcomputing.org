require 'rails_helper'

RSpec.describe ActivityPresenter do
  let(:empty_presenter) { described_class.new(nil) }
  let(:decorating_presenter) { described_class.new([0, 1, 2]) }

  describe('empty?') do
    it 'returns true if the presenter has no delegate' do
      expect(empty_presenter.empty?).to eq(true)
    end

    it 'returns false if the presenter has a delegate' do
      expect(decorating_presenter.empty?).to eq(false)
    end
  end

  describe('button_label') do
    it { expect(empty_presenter.button_label).to eq('Start a course') }
  end

  describe('button_url') do
    it { expect(empty_presenter.button_url).to eq('/') }
  end

  describe('completed_text') do
    it { expect(empty_presenter.completed_text(0)).to eq('Completed your first course') }
  end

  describe('prompt_text') do
    it { expect(empty_presenter.prompt_text(1)).to eq('Complete your second course') }
  end

  describe('inspect') do
    it { expect(empty_presenter.inspect).to start_with("ActivityPresenter - empty? true\nnil") }
  end

  describe('delegates correctly') do
    it { expect(decorating_presenter.size).to eq(3) }
  end
end
