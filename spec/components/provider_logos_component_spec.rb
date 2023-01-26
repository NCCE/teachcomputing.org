require 'rails_helper'

RSpec.describe ProviderLogosComponent, type: :component do
  let(:data) do
    {
      online: false,
      dashboard: false,
      class_name: 'custom-class'
    }
  end

  context 'when options are all false' do
    before do
      render_inline(described_class.new(**data))
    end

    it 'adds the wrapper class' do
      expect(page).to have_css('.custom-class')
    end

    it 'does not add the modifier' do
      expect(page).not_to have_css('.provider-logos-component--dashboard')
    end

    it 'falls back to stem org_prefix' do
      expect(page).to have_text('This course is from Teach Computing and delivered by STEM Learning')
    end

    it 'has the expected logos' do
      expect(page).to have_css("img[src*='tc-logo-small']")
      expect(page).to have_css("img[src*='stem-logo-small']")
    end
  end

  context 'when online is true' do
    before do
      data[:online] = true
      render_inline(described_class.new(**data))
    end

    it 'uses the rpf org_prefix' do
      expect(page).to have_text('This course is from Teach Computing and delivered by Raspberry Pi Foundation')
    end

    it 'has the expected logos' do
      expect(page).to have_css("img[src*='tc-logo-small']")
      expect(page).to have_css("img[src*='rpf-logo-small']")
    end
  end

  context 'when dashboard is true and online is false' do
    before do
      data[:dashboard] = true
      render_inline(described_class.new(**data))
    end

    it 'adds the modifier' do
      expect(page).to have_css('.provider-logos-component--dashboard')
    end

    it 'has the expected logos' do
      expect(page).to have_css("img[src*='tc-logo-small']")
      expect(page).to have_css("img[src*='stem-logo-small']")
    end
  end

  context 'when dashboard is true and online is true' do
    before do
      data[:dashboard] = true
      data[:online] = true
      render_inline(described_class.new(**data))
    end

    it 'adds the modifier' do
      expect(page).to have_css('.provider-logos-component--dashboard')
    end

    it 'has the expected logos' do
      expect(page).to have_css("img[src*='tc-logo-small']")
      expect(page).to have_css("img[src*='rpf-logo-small']")
      expect(page).to have_css("img[src*='fl-logo-small']")
    end
  end
end
