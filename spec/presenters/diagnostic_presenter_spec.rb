require 'rails_helper'

RSpec.describe DiagnosticPresenter do
  let(:user) { create(:user) }
  let(:empty_presenter) { described_class.new(nil) }

  describe('button_label') do
    it { expect(empty_presenter.button_label).to eq('Use the diagnostic tool') }
  end

  describe('button_url') do
    it { expect { empty_presenter.button_url }.to raise_error(NoMethodError) }
    it { expect(empty_presenter.button_url({ current_user: user })).to start_with("/activities/redirects") }
    it { expect(empty_presenter.button_url({ current_user: user })).to include("user_id%3D#{user.id}") }
  end

  describe('completed_text') do
    it { expect(empty_presenter.completed_text(0)).to eq('Used the diagnostic tool') }
  end

  describe('prompt_text') do
    it { expect(empty_presenter.prompt_text(1)).to eq('Optionally, use the diagnostic tool') }
  end

  describe('inspect') do
    it { expect(empty_presenter.inspect).to start_with("DiagnosticPresenter - empty? true") }
  end
end
