require 'rails_helper'

RSpec.describe('pages/enrolment/a_level_certificate', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:a_level) }

  before do
    @programme = programme
  end

  before do
    render(
      template: 'pages/enrolment/a_level_certificate',
      locals: { current_user: user }
    )
  end

  it 'has open heading' do
    expect(rendered).to have_text('Demonstrate your A level Computer Science knowledge and your commitment to the subject.')
  end

  it 'has a who is it for section' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'Who is it for?')
  end

  it 'has a how do I get started section' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'How do I get started?')
  end

  it 'has an enrol button' do
    expect(rendered).to have_link('Enrol to gain access')
  end

  it 'has a isaac section' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'How we can help you and your students')
  end

  it 'has an isaac CS section' do
    expect(rendered).to have_link('Discover Isaac Computer Science', href: 'https://isaaccomputerscience.org/')
  end

  describe 'hero section' do
    it 'has title' do
      expect(rendered).to have_css('.govuk-heading-l', text: @programme.title)
    end

    it 'has sub title' do
      expect(rendered).to have_css('.govuk-body-l', text: 'Certificate awarded by BCS, The Chartered Institute for IT')
    end

    it 'has BCS logo' do
      expect(rendered).to have_css('.text-certificate-hero__area--logo img')
    end
  end
end
