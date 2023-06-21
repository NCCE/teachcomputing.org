require 'rails_helper'

RSpec.describe AsideComponent, type: :component do
  context 'when use_button option is false or not passed' do
    before do
      render_inline(
        described_class.new(
          title: 'Test title',
          text: 'The body text',
          link: {
            url: 'http://example.com',
            text: 'The link text'
          }
        )
      )
    end

    it 'renders the title text' do
      expect(page).to have_text('Test title')
    end

    it 'renders the expected class on the title' do
      expect(page).to have_css('h2.govuk-heading-s')
    end

    it 'renders the body text' do
      expect(page).to have_text('The body text')
    end

    it 'renders the expected link' do
      expect(page).to have_link('The link text', href: 'http://example.com')
    end

    it 'renders the expected classes on the link' do
      expect(page).to have_css('a.ncce-link')
    end
  end

  context 'when use_button option is true' do
    before do
      render_inline(
        described_class.new(
          title: 'Test title',
          text: 'The body text',
          use_button: true,
          link: {
            url: 'http://example.com',
            text: 'The link text'
          }
        )
      )
    end

    it 'renders the expected class on the title' do
      expect(page).to have_css('h2.govuk-heading-s')
    end

    it 'renders the expected classes on the link' do
      expect(page).to have_css('a.govuk-button')
    end
  end

  context 'when no link is passed' do
    it 'does not render the link' do
      render_inline(
        described_class.new(
          title: 'Test title',
          text: 'The body text'
        )
      )

      expect(page).not_to have_css('.aside-component__link')
    end
  end

  context 'when no title is passed' do
    it 'does not render a title' do
      render_inline(
        described_class.new(
          text: 'The body text'
        )
      )

      expect(page).not_to have_css('.aside-component__heading')
    end
  end

  context 'when no image is passed' do
    it 'does not render an image' do
      render_inline(
        described_class.new(
          text: 'The body text'
        )
      )

      expect(page).not_to have_css('.aside-component__image')
    end
  end

  context 'when an image is passed' do
    before do
      render_inline(
        described_class.new(
          title: 'Test title',
          text: 'The body text',
          image: {
            file: 'media/images/icons/curriculum-journey.png',
            title: 'Image',
            url: 'https://static.teachcomputing.org/curriculum_journey.pdf'
          }
        )
      )
    end

    it 'renders an image' do
      expect(page).to have_css('.aside-component__image')
      expect(page).to have_css("img[src*='curriculum-journey']")
    end

    it 'renders a link' do
      expect(page).to have_link('', href: 'https://static.teachcomputing.org/curriculum_journey.pdf')
    end
  end
end
