require 'rails_helper'

RSpec.describe FaceToFacePresenter do
  let(:empty_presenter) { described_class.new(nil) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:presenter) do
    described_class.new(create(:achievement, programme_id: secondary_certificate.id), secondary_certificate)
  end

  before do
    secondary_certificate
  end

  describe('button_url') do
    it { expect(empty_presenter.button_url).to eq('/courses?course_format%5B%5D=face_to_face') }

    it {
      expect(empty_presenter.button_url({ certificate: 'cs-accelerator' })).to eq('/courses?certificate=cs-accelerator&course_format%5B%5D=face_to_face')
    }
  end

  describe('completed_text') do
    it { expect(empty_presenter.completed_text(0)).to eq('Completed your first face to face, or remote course') }
  end

  describe('prompt_text') do
    it { expect(empty_presenter.prompt_text(1)).to eq('Complete your second face to face, or remote course') }

    context 'when the the achievement belongs to secondary certificate' do
      it { expect(presenter.prompt_text(1)).to eq('Complete at least one face to face, or remote course') }
    end
  end

  describe('inspect') do
    it { expect(empty_presenter.inspect).to start_with('FaceToFacePresenter - empty? true') }
  end
end
