require 'rails_helper'

RSpec.describe('programmes/complete', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }

  before do
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('h1', text: 'Congratulations')
  end

  it 'has the programme title' do
    expect(rendered).to have_css('h2', text: @programme.title)
  end

  it 'has the download button' do
    expect(rendered).to have_link('View your certificate', href: '/certificate/cs-accelerator/view-certificate')
  end
end
