require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Maintenance message', type: :system, js: true) do
  let(:browser) { page.driver.browser }
  let(:cookie_name) { 'maintenance-modal-20190829' }

  context 'when user first visits a page' do
    before do
      stub_featured_posts
      visit root_path
    end

    it 'the popup message is shown' do
      expect(page).to have_css('.modal__container', visible: true)
    end

    it 'the cookie is not set' do
      expect do
        browser.manage.cookie_named(cookie_name)
      end.to raise_error(Selenium::WebDriver::Error::NoSuchCookieError)
    end

    context 'I can dismiss the message' do
      before do
        browser.manage.delete_all_cookies
        visit root_path
        find('.govuk-button[data-micromodal-close]').click
      end

      xit 'and the popup is hidden' do
        expect(page).not_to have_css('.modal__container', visible: true)
      end

      xit 'and the cookie is set' do
        cookie = browser.manage.cookie_named(cookie_name)
        puts cookie
        expect(cookie.value).to eq(true)
      end
    end
  end

  context 'when the user has acknowledge the message' do
    before do
      stub_featured_posts
      visit root_path
      browser.manage.delete_all_cookies
      browser.manage.add_cookie name: cookie_name, value: true.to_s
    end

    xit 'the popup message doesn\'t show' do
      expect(page).not_to have_css('.modal__container', visible: true)
    end
  end
end
