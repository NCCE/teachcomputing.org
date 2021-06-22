require 'rails_helper'

RSpec.describe HubSocialLinkComponent, type: :component do
  it 'does not render when value is empty' do
    render_inline(described_class.new(type: 'twitter', value: nil))
    expect(rendered_component).to eq ''
  end

  context 'when type is twitter' do
    it 'renders correct image' do
      render_inline(described_class.new(type: 'twitter', value: '@twithandle'))
      expect(rendered_component).to include('packs-test/media/images/hubs/twitter-')
      expect(rendered_component)
        .to have_xpath('//img[contains(@class, "hub-social-link-component__image")][contains(@alt, "twitter icon")]')
    end

    it 'displays link to twitter' do
      render_inline(described_class.new(type: 'twitter', value: '@twithandle'))
      expect(rendered_component).to have_link('', href: 'https://twitter.com/@twithandle')
    end
  end

  context 'when type is facebook' do
    it 'renders correct image' do
      render_inline(described_class.new(type: 'facebook', value: 'facehandle'))
      expect(rendered_component).to include('packs-test/media/images/hubs/facebook-')
      expect(rendered_component)
        .to have_xpath('//img[contains(@class, "hub-social-link-component__image")][contains(@alt, "facebook icon")]')
    end

    it 'displays link to facebook' do
      render_inline(described_class.new(type: 'facebook', value: 'facehandle'))
      expect(rendered_component).to have_link('', href: 'https://facebook.com/facehandle')
    end
  end

  context 'when type is website' do
    it 'renders correct image' do
      render_inline(described_class.new(type: 'website', value: 'https://www.example.com'))
      expect(rendered_component).to include('packs-test/media/images/hubs/website-')
      expect(rendered_component)
        .to have_xpath('//img[contains(@class, "hub-social-link-component__image")][contains(@alt, "website icon")]')
    end

    it 'displays link to website' do
      render_inline(described_class.new(type: 'website', value: 'https://www.example.com'))
      expect(rendered_component).to have_link('', href: 'https://www.example.com')
    end
  end
end
