require 'rails_helper'

RSpec.describe('welcome/show', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('h1', text: 'Welcome to Teach Computing')
  end

  it 'has the cs_accelerator card' do
    expect(rendered).to have_css('.card__heading', text: 'Teach GCSE computer science')
  end

  it 'has the primary certificate card' do
    expect(rendered).to have_css('.card__heading', text: 'Teach primary computing')
  end

  it 'has the enrol button for cs_accelerator card' do
    expect(rendered).to have_link('Enrol now', href: cs_accelerator_path)
  end

  it 'has the enrol button for primary certificate card' do
    expect(rendered).to have_link('Enrol now', href: primary_path)
  end
end
