require 'rails_helper'

RSpec.describe('components/_feedback', type: :view) do
  before do
    render
  end

  it('renders the feedback banner') do
    expect(rendered).to(have_css('.ncce-feedback'))
  end

  it 'text to send feedback note' do
    expect(rendered).to have_css('.ncce-link__on-light', text: 'feedback')
  end

  it 'links to the feedback mail' do
    expect(rendered).to have_link('feedback', href: 'mailto:info@teachcomputing.org')
  end

end
