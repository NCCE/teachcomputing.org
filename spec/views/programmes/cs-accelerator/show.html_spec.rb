require 'rails_helper'

RSpec.describe('programmes/cs-accelerator/show', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }

  before do
    @current_user = user
    @programme = programme
		stub_template 'programmes/cs-accelerator/_activity-list.html.erb' => 'stub activity list'
		stub_template 'programmes/cs-accelerator/_aside.html.erb' => 'stub aside'
    render
  end

  it 'has one heading' do
    expect(rendered).to have_css('.govuk-heading-s', count: 2)
  end

	it 'has one courses button' do
    expect(rendered).to have_link('Book or join a course today', href: /cs-accelerator/)
  end

end
