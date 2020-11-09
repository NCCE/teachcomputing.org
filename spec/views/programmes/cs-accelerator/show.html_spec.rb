require 'rails_helper'

RSpec.describe('certificates/cs_accelerator/show', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }

  before do
    @current_user = user
    @programme = programme
    stub_template 'certificates/cs_accelerator/_activity-list.html.erb' => 'stub activity list'
    stub_template 'certificates/cs_accelerator/_aside.html.erb' => 'stub aside'
    render
  end

  it 'has the hero' do
    expect(rendered).to have_css('.hero__heading', text: programme.title)
  end

  it 'has a heading' do
    expect(rendered).to have_css('.govuk-heading-m')
  end

  it 'has an activity heading' do
    expect(rendered).to have_css('.govuk-heading-s')
  end

  it 'has one courses button' do
    expect(rendered).to have_link('Book or join a course today', href: /cs-accelerator/)
  end

  it 'has the expected bursary info' do
    expect(rendered).to have_css('.bursary-info', text: /secondary teacher/)
  end
end
