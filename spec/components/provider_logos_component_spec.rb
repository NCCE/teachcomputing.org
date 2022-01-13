require 'rails_helper'

RSpec.describe ProviderLogosComponent, type: :component do
  let(:data) do
    {
      online: false,
      inline: false,
      class_name: 'custom-class'
    }
  end

  context 'when options are all false' do
    before do
      render_inline(described_class.new(data))
    end

    it 'adds the wrapper class' do
      expect(rendered_component).to have_css('.custom-class')
    end

    it 'does not add the modifier' do
      expect(rendered_component).not_to have_css('.provider-logos-component--inline')
    end

    it 'falls back to stem org_prefix' do
      expect(rendered_component).to have_text('This course is from Teach Computing and delivered by STEM Learning')
    end

    it 'has the expected logos' do
      expect(rendered_component).to have_css("img[src*='tc-logo-small']")
      expect(rendered_component).to have_css("img[src*='stem-logo-small']")
    end
  end

  context 'when online is true' do
    before do
      data[:online] = true
      render_inline(described_class.new(data))
    end

    it 'uses the rpf org_prefix' do
      expect(rendered_component).to have_text('This course is from Teach Computing and delivered by Raspberry Pi Foundation')
    end

    it 'has the expected logos' do
      expect(rendered_component).to have_css("img[src*='tc-logo-small']")
      expect(rendered_component).to have_css("img[src*='rpf-logo-small']")
    end
  end

  context 'when inline is true' do
    before do
      data[:inline] = true
      render_inline(described_class.new(data))
    end

    it 'adds the modifier' do
      expect(rendered_component).to have_css('.provider-logos-component--inline')
    end
  end
end
