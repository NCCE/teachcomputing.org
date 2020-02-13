require 'rails_helper'

RSpec.describe('cms/cms_page', type: :view) do
  before do
    stub_cms_page
    @page = Ghost.new.get_single_page('bursary')
    render
  end

  it('renders the title') do
    expect(rendered).to have_css('.hero__heading', text: @page['meta_title'])
  end

  it('renders the content') do
    expect(rendered).to have_css('.cms-content', text: /This is a test page/)
  end
end
