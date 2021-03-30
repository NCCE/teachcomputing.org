require 'rails_helper'

RSpec.describe SecondaryLandingPage do
  # let!(:csa) { create(:cs_accelerator) }
  let!(:csa) { instance_double(Programmes::CSAccelerator) }
  # let!(:secondary_cert) { create(:secondary_certificate) }
  let!(:secondary_cert) { instance_double(Programmes::SecondaryCertificate) }
  let(:user) { create(:user) }

  let(:landing_page) { SecondaryLandingPage.new(current_user: user) }

  before do
    allow(Programme).to receive(:cs_accelerator) { csa }
    allow(Programme).to receive(:secondary_certificate) { secondary_cert }
  end

  it 'exposes csa' do
    expect(landing_page.cs_accelerator).to eq(csa)
  end

  it 'exposes secondary certificate' do
    expect(landing_page.secondary_certificate).to eq(secondary_cert)
  end

  describe 'certificates text' do
    it 'returns text' do
      expect(landing_page.certificates_text).to match(/Improve your subject knowledge/)
    end
  end

  describe '#secondary?' do
    it 'returns true' do
      expect(landing_page.secondary?).to eq(true)
    end
  end

  describe '#csa_link_text' do
    context 'when user enrolled on csa' do
      it 'returns correct text' do
        allow(csa).to receive(:user_enrolled?).and_return(true)
        expect(landing_page.csa_link_text).to eq('View your progress')
      end
    end

    context 'when user not enrolled on csa' do
      it 'returns correct text' do
        allow(csa).to receive(:user_enrolled?).and_return(false)
        expect(landing_page.csa_link_text).to eq('Find out more')
      end
    end
  end

  describe '#secondary_cert_link_text' do
    context 'when user enrolled on secondary certificate' do
      it 'returns correct text' do
        allow(secondary_cert).to receive(:user_enrolled?).and_return(true)
        expect(landing_page.secondary_cert_link_text).to eq('View your progress')
      end
    end

    context 'when user not enrolled on secondary certificate' do
      it 'returns correct text' do
        allow(secondary_cert).to receive(:user_enrolled?).and_return(false)
        expect(landing_page.secondary_cert_link_text).to eq('Find out more')
      end
    end
  end

  describe '#testimonials' do
    it 'returns 3 testimonials' do
      expect(landing_page.testimonials.length).to eq(3)
    end

    it 'returns correctly shaped data' do
      keys = %i[text image name link_target bio]

      expect(landing_page.testimonials.map(&:keys)).to eq(Array.new(3, keys))
    end
  end

  describe '#courses_intro' do
    it 'returns text' do
      expect(landing_page.courses_intro).to match(/Begin your computing journey/)
    end
  end

  describe '#courses' do
    it 'returns 3 courses' do
      expect(landing_page.courses.length).to eq(3)
    end

    it 'returns correctly shaped data' do
      keys = %i[image title url description icon_class type duration time_commitment]

      expect(landing_page.courses.map(&:keys)).to eq(Array.new(3, keys))
    end
  end

  describe '#resources_text' do
    it 'returns text' do
      expect(landing_page.resources_text).to match(/Free teaching resources/)
    end
  end

  describe '#resources' do
    it 'returns 2 resources' do
      expect(landing_page.resources.length).to eq(2)
    end

    it 'returns correctly shaped data' do
      keys = %i[title url description]

      expect(landing_page.resources.map(&:keys)).to eq(Array.new(2, keys))
    end
  end
end
