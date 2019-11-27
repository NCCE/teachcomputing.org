require 'rails_helper'

RSpec.describe FaceToFacePresenter do
  let(:empty_presenter) { described_class.new(nil) }

  describe('button_label') do
    it { expect(empty_presenter.button_label).to eq('Book a face to face course') }
  end

  describe('button_url') do
    it { expect(empty_presenter.button_url).to eq('/courses?location=Face+to+face') }
    it { expect(empty_presenter.button_url({ certificate: 'cs-accelerator' })).to eq('/courses?certificate=cs-accelerator&location=Face+to+face') }
  end

  describe('completed_text') do
    it { expect(empty_presenter.completed_text(0)).to eq('Completed your first face to face course') }
  end

  describe('prompt_text') do
    it { expect(empty_presenter.prompt_text(1)).to eq('Complete your second face to face course') }
  end

  describe('inspect') do
    it { expect(empty_presenter.inspect).to start_with('FaceToFacePresenter - empty? true') }
  end
end
